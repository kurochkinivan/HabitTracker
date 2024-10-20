import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';
import '../router/app_router.dart';
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

    _isPassword1Valid.value = isPassword1Valid && isPasswordsMatch;
    _isPassword2Valid.value = isPassword2Valid && isPasswordsMatch;
    setState(() {});
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 64.h, left: 20),
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/images/Arrow_left.svg",
                  height: 32.w,
                  width: 32.w,
                  fit: BoxFit.contain,
                ),
                onPressed: () {
                  context.router.navigate(PasswordRecoveryRoute());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 32.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    "Введите новый пароль",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 26.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                      "Введите свой email, и мы отправим вам код для восстановления пароля.",
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: 24.h),
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
                  SizedBox(height: 10.h),
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
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            text: 'Продолжить',
            isEnabled: _isPassword2Valid.value &&
                _passwordController1.text.isNotEmpty &&
                _passwordController2.text.isNotEmpty,
            onPressed: () {},
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
