import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/text_field_error_message.dart';

@RoutePage()
class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  NewPasswordPageState createState() => NewPasswordPageState();
}

class NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  bool _isPassword1Valid = true;
  bool _isPassword2Valid = true;
  bool _isPassword1Correct = true;

  void _validatePasswords() {
    final password1 = _passwordController1.text;
    final password2 = _passwordController2.text;

    final bool isPassword1Valid = password1.length >= 6 || password1.isEmpty;
    final bool isPassword2Valid = password2.length >= 6 || password2.isEmpty;
    final bool isPasswordsMatch = password1 == password2 || password2.isEmpty;

    setState(() {
      _isPassword1Correct = isPassword1Valid;
      _isPassword1Valid = isPassword1Valid && isPasswordsMatch;
      _isPassword2Valid = isPassword2Valid && isPasswordsMatch;
    });
  }

  @override
  void dispose() {
    _passwordController1.dispose();
    _passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88.h,
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(
            left: 8.w,
            right: 32.w,
          ),
          child: Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/arrow_left.svg",
                  height: 32.w,
                  width: 32.w,
                  fit: BoxFit.contain,
                ),
                onPressed: () {
                  context.router.back();
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                  "Введите свой email, и мы отправим вам код для восстановления пароля.",
                  style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 24.h),
              CustomTextFormField(
                controller: _passwordController1,
                hintText: 'Новый пароль',
                obscureText: true,
                isValid: _isPassword1Valid,
                onChanged: _validatePasswords,
              ),
              TextFieldErrorMessage(
                  isValid: _isPassword1Correct,
                  message: "Слишком короткий пароль"),
              SizedBox(height: 10.h),
              CustomTextFormField(
                controller: _passwordController2,
                hintText: 'Повторите пароль',
                obscureText: true,
                isValid: _isPassword2Valid,
                onChanged: _validatePasswords,
              ),
              TextFieldErrorMessage(
                  isValid: _isPassword2Valid,
                  message: "Слишком короткий пароль или пароли не совпадают"),
            ],
          ),
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
            isEnabled: _isPassword2Valid &&
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
