import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';
import '../router/app_router.dart';
import '../ui_scaling.dart';
import '../widgets/custom_text_form_field.dart';

@RoutePage()
class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  PasswordRecoveryPageState createState() => PasswordRecoveryPageState();
}

class PasswordRecoveryPageState extends State<PasswordRecoveryPage> {

  static RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$');
  bool nameError = true;
  bool emailError = true;
  bool passError = true;

  void validateEmail(String text) {
    setState(() {
      emailError = emailRegex.hasMatch(text);
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
              context.router.navigate(SignInRoute());
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: scaling.scaleHeight(16)),
              Text("Восстановление пароля",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: scaling.scaleWidth(26))),
              SizedBox(height: scaling.scaleHeight(8)),
              Text(
                  "Введите свой email, и мы отправим "
                  "вам код для восстановления пароля.",
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
              SizedBox(height: scaling.scaleHeight(18)),
              if (!emailError)
                Text(
                  "Некорректный формат почты",
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
              context.router.navigate(VerifyPasswordRecoveryRoute());
            },
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
