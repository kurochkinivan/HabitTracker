import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';
import '../router/app_router.dart';
import '../ui_scaling.dart';
import '../widgets/custom_text_form_field.dart';

@RoutePage()
class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  NewPasswordPageState createState() => NewPasswordPageState();
}

class NewPasswordPageState extends State<NewPasswordPage> {
  bool passError1 = true;
  bool passError2 = true;
  bool isPasswordsMatch = true;

  void validatePassword1(String text) {
    setState(() {
      passError1 = text.length >= 6;
    });
  }

  void validatePassword2(String text) {
    setState(() {
      passError2 = text.length >= 6;
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
              context.router.navigate(PasswordRecoveryRoute());
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: scaling.scaleHeight(16)),
              Text("Введите новый пароль",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: scaling.scaleWidth(26))),
              SizedBox(height: scaling.scaleHeight(8)),
              Text(
                  "Введите свой email, и мы отправим вам код для восстановления пароля.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: scaling.scaleWidth(14))),
              SizedBox(height: scaling.scaleHeight(30)),
              CustomTextFormField(
                hintText: 'Новый пароль',
                obscureText: true,
                validate: (text) {
                  validatePassword1(text);
                  return passError1;
                },
              ),
              SizedBox(height: scaling.scaleHeight(10)),
              CustomTextFormField(
                hintText: 'Повторите пароль',
                obscureText: true,
                validate: (text) {
                  validatePassword2(text);
                  return passError2;
                },
              ),
              SizedBox(height: scaling.scaleHeight(18)),
              if (!passError1 | !passError2)
                Text(
                  "Слишком короткий пароль",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: scaling.scaleWidth(12)),
                ),
              if (!isPasswordsMatch)
                Text(
                  "Пароли не совпадают",
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
            onPressed: () {},
            child: Center(
              child: Text(
                'Отправить код',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: scaling.scaleWidth(14)),
              ),
            ),
          ),
          SizedBox(
            height: scaling.scaleHeight(32),
          ),
        ],
      ),
    );
  }
}
