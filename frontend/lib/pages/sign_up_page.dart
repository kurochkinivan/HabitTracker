import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';
import '../router/app_router.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/password_error_message.dart';
import '../services/auth_service.dart';
import '../models/auth_models.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  static final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<bool> _isNameValid = ValueNotifier(true);
  final ValueNotifier<bool> _isEmailValid = ValueNotifier(true);
  final ValueNotifier<bool> _isPasswordValid = ValueNotifier(true);

  final AuthService _authService = AuthService();

  // Функция для регистрации
  void _register() async {
    final request = RegisterRequest(
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );
    await _authService.registerUser(request);
  }

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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _isNameValid.dispose();
    _isEmailValid.dispose();
    _isPasswordValid.dispose();
    super.dispose();
  }

  void _validateInputs() {
    final bool isNameValid =
        _nameController.text.length > 1 || _nameController.text.isEmpty;
    final bool isEmailValid = emailRegex.hasMatch(_emailController.text) ||
        _emailController.text.isEmpty;
    final bool isPasswordValid = _passwordController.text.length >= 6 ||
        _passwordController.text.isEmpty;

    _isNameValid.value = isNameValid;
    _isEmailValid.value = isEmailValid;
    _isPasswordValid.value = isPasswordValid;
    setState(() {});
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
                    "Регистрация",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 26.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                      "Присоединяйся к сообществу, где каждый шаг "
                      "приближает тебя к лучшей цели!",
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    controller: _nameController,
                    hintText: 'Имя',
                    obscureText: false,
                    validateController: _isNameValid,
                    onChanged: _validateInputs,
                  ),
                  PasswordErrorMessage(
                    validator: _isNameValid,
                    message: "Слишком короткое имя",
                  ),
                  SizedBox(height: 10.h),
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
            text: 'Зарегистрироваться',
            isEnabled: _isNameValid.value &&
                _isEmailValid.value &&
                _isPasswordValid.value &&
                _nameController.text.isNotEmpty &&
                _emailController.text.isNotEmpty &&
                _passwordController.text.isNotEmpty,
            onPressed: _register,
          ),
          SizedBox(height: 12.h),
          OutlinedButton(
            onPressed: () {},
            child: Center(
              child: Text(
                'Зарегистрироваться с помощью Google',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 14.sp, color: AppColors.black01),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.router.navigate(SignInRoute());
            },
            child: Text(
              'У меня уже есть аккаунт',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
