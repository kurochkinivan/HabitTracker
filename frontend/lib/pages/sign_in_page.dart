import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker/app_colors.dart';
import '../router/app_router.dart';
import '../ui_scaling.dart';
import '../widgets/custom_text_form_field.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  static RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$');

  bool emailError = true;
  bool passError = true;

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

  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

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
              Text("Вход",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: scaling.scaleWidth(26))),
              SizedBox(height: scaling.scaleHeight(8)),
              Text(
                  "С возвращением! Продолжай улучшать свои "
                  "привычки — каждый шаг важен на пути к успеху.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: scaling.scaleWidth(14))),
              SizedBox(height: scaling.scaleHeight(30)),
              CustomTextFormField(
                hintText: 'E-mail',
                obscureText: false,
                validate: (text) {
                  validateEmail(text);
                  return emailError;
                },
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
              SizedBox(height: scaling.scaleHeight(18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: scaling.scaleHeight(64),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!emailError)
                              Text(
                                "Некорректный формат почты",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        fontSize: scaling.scaleWidth(12)),
                              ),
                            if (!passError)
                              Text(
                                "Слишком короткий пароль",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        fontSize: scaling.scaleWidth(12)),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        context.router.navigate(PasswordRecoveryRoute());
                      },
                      child: Text(
                        "Восстановить пароль",
                        style: TextStyle(
                          color: AppColors.black02,
                          fontSize: scaling.scaleWidth(12),
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          letterSpacing: 0.2,
                          height: 1.3,
                        ),
                      )),
                ],
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
            onPressed: () {},
            child: Center(
              child: Text(
                'Войти',
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
                'Войти с помощью Google',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: scaling.scaleWidth(14), color: AppColors.black01),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.router.navigate(SignUpRoute());
            },
            child: Text(
              'У меня еще нет аккаунта',
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
