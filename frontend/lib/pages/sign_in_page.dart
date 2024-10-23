import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker/app_colors.dart';
import '../models/auth_models.dart';
import '../router/app_router.dart';
import '../services/auth_service.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/password_error_message.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  static final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<bool> _isEmailValid = ValueNotifier(true);
  final ValueNotifier<bool> _isPasswordValid = ValueNotifier(true);

  final AuthService _authService = AuthService();

  // Функция для входа
  void _login() async {
    final request = LoginRequest(
      email: _emailController.text,
      password: _passwordController.text,
    );
    final response = await _authService.loginUser(request);

    if (response != null) {
      print('Logged in! JWT: ${response.jwt}');
    }
  }

  void _validateInputs() {
    final bool isEmailValid = emailRegex.hasMatch(_emailController.text) ||
        _emailController.text.isEmpty;
    final bool isPasswordValid = _passwordController.text.length >= 6 ||
        _passwordController.text.isEmpty;

    _isEmailValid.value = isEmailValid;
    _isPasswordValid.value = isPasswordValid;
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _isEmailValid.dispose();
    _isPasswordValid.dispose();
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
                  context.router.navigate(StartRoute());
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
                    "Вход",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 26.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "С возвращением! Продолжай улучшать свои "
                    "привычки — каждый шаг важен на пути к успеху.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: 'E-mail',
                    obscureText: false,
                    validateController: _isEmailValid,
                    onChanged: _validateInputs,
                  ),
                  PasswordErrorMessage(
                    validator: _isEmailValid,
                    message: "Некорректный формат почты",
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: 'Пароль',
                    obscureText: true,
                    validateController: _isPasswordValid,
                    onChanged: _validateInputs,
                  ),
                  PasswordErrorMessage(
                    validator: _isPasswordValid,
                    message: "Слишком короткий пароль",
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(8.w),
                        onTap: () {
                          context.router.navigate(PasswordRecoveryRoute());
                        },
                        child: Text(
                          "Восстановить пароль",
                          style: TextStyle(
                            color: AppColors.black02,
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            letterSpacing: 0.2,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
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
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            text: 'Войти',
            isEnabled: _isEmailValid.value &&
                _isPasswordValid.value &&
                _emailController.text.isNotEmpty &&
                _passwordController.text.isNotEmpty,
            onPressed: _login,
          ),
          SizedBox(height: 12.h),
          OutlinedButton(
            onPressed: () {
              // Handle Google sign-in
            },
            child: Center(
              child: Text(
                'Войти с помощью Google',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 14.sp, color: AppColors.black01),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.router.navigate(SignUpRoute());
            },
            child: Text(
              'У меня еще нет аккаунта',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }
}
