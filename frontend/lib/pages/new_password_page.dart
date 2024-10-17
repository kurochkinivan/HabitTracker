import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';

import '../ui_scaling.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field_widget.dart';
import '../widgets/password_error_message_widget.dart';

@RoutePage()
class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  NewPasswordPageState createState() => NewPasswordPageState();
}

class NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  final ValueNotifier<bool> _isPassword1Valid = ValueNotifier(true);
  final ValueNotifier<bool> _isPassword2Valid = ValueNotifier(true);

  void _validatePasswords() {
    final password1 = _passwordController1.text;
    final password2 = _passwordController2.text;

    final bool isPassword1Valid = password1.length >= 6 || password1.isEmpty;
    final bool isPassword2Valid = password2.length >= 6 || password2.isEmpty;
    final bool isPasswordsMatch = password1 == password2 || password2.isEmpty;

    _isPassword1Valid.value = isPassword1Valid;
    _isPassword2Valid.value = isPassword2Valid && isPasswordsMatch;
  }

  @override
  void dispose() {
    _passwordController1.dispose();
    _passwordController2.dispose();
    _isPassword1Valid.dispose();
    _isPassword2Valid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaling = Scaling.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                onPressed: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: scaling.scaleHeight(16)),
                  Text(
                    "Введите новый пароль",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: scaling.scaleWidth(26)),
                  ),
                  SizedBox(height: scaling.scaleHeight(8)),
                  Text(
                    "Введите свой email, и мы отправим вам код для восстановления пароля.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: scaling.scaleWidth(14)),
                  ),
                  SizedBox(height: scaling.scaleHeight(24)),
                  CustomTextFormField(
                    controller: _passwordController1,
                    hintText: 'Новый пароль',
                    obscureText: true,
                    validateController: _isPassword1Valid,
                    onChanged: _validatePasswords,
                  ),
                  PasswordErrorMessage(
                      validator: _isPassword1Valid,
                      message: "Слишком короткий пароль"),
                  SizedBox(height: scaling.scaleHeight(10)),
                  CustomTextFormField(
                    controller: _passwordController2,
                    hintText: 'Повторите пароль',
                    obscureText: true,
                    validateController: _isPassword2Valid,
                    onChanged: _validatePasswords,
                  ),
                  PasswordErrorMessage(
                      validator: _isPassword2Valid,
                      message:
                          "Слишком короткий пароль или пароли не совпадают"),
                ],
              ),
            ),
          ],
        ),
      ),
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
          CustomElevatedButton(
            text: 'Продолжить',
            isEnabled: _isPassword2Valid.value &&
                _passwordController1.text.isNotEmpty &&
                _passwordController2.text.isNotEmpty,
            onPressed: () {

            },
          ),
          SizedBox(height: scaling.scaleHeight(32)),
        ],
      ),
    );
  }
}
