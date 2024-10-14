import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';
import '../router/app_router.dart';
import '../ui_scaling.dart';
import '../widgets/custom_text_form_field.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  static RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$');
  bool nameError = true;
  bool emailError = true;
  bool passError = true;


  void validateName(String text) {
    setState(() {
      nameError = text.length > 1;
    });
  }

  void validateEmail(String text) {
    setState(() {
      emailError = emailRegex.hasMatch(text);
    });
  }

  void validatePassword(String text) {
    setState(() {
      passError = text.length >= 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaling = Scaling.of(context);
    return Scaffold(
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(top: 64, left: 20),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/images/Arrow_left.svg",
              height: scaling.scaleWidth(32),
              width: scaling.scaleWidth(32),
              fit: BoxFit.contain,
              color: AppColors.grey01,
            ),
            onPressed: () {
              context.router.navigate(StartRoute());
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: scaling.scaleHeight(16)),
              Text("Регистрация",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: scaling.scaleWidth(26))),
              SizedBox(height: scaling.scaleHeight(8)),
              Text(
                  "Присоединяйся к сообществу, где каждый шаг "
                  "приближает тебя к лучшей цели!",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: scaling.scaleWidth(14))),
              SizedBox(height: scaling.scaleHeight(30)),
              CustomTextFormField(
                hintText: 'Имя',
                obscureText: false,
                validate: (text) {
                  validateName(text);
                  return nameError;
                },
              ),
              if (!nameError)
                Text(
                  "Слишком короткое имя",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: scaling.scaleWidth(12)),
                ),
              SizedBox(height: scaling.scaleHeight(10)),
              CustomTextFormField(
                hintText: 'E-mail',
                obscureText: false,
                validate: (text) {
                  validateEmail(text);
                  return emailError;
                },
              ),
              if (!emailError)
                Text(
                  "Некорректный формат почты",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: scaling.scaleWidth(12)),
                ),
              SizedBox(height: scaling.scaleHeight(10)),
              CustomTextFormField(
                hintText: 'Пароль',
                obscureText: true,
                validate: (text) {
                  validatePassword(text);
                  return passError;
                },
              ),
              if (!passError)
                Text(
                  "Слишком короткий пароль",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: scaling.scaleWidth(12)),
                ),
            ],
          ),
        ),
      ])),
      bottomNavigationBar: _buildActionButtons(context),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final scaling = Scaling.of(context);
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              context.router.navigate(VerifyEmailRoute());
            },
            child: Center(
              child: Text(
                'Зарегистрироваться',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: scaling.scaleWidth(14)),
              ),
            ),
          ),
          SizedBox(height: scaling.scaleHeight(12)),
          OutlinedButton(
            onPressed: () {},
            child: Center(
              child: Text(
                'Зарегистрироваться с помощью Google',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: scaling.scaleWidth(14), color: AppColors.black01),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.router.navigate(SignInRoute());
            },
            child: Text(
              'У меня уже есть аккаунт',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: scaling.scaleWidth(14)),
            ),
          ),
          SizedBox(
            height: scaling.scaleHeight(16),
          ),
        ],
      ),
    );
  }
}
