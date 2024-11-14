import 'package:android_id/android_id.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../router/app_router.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/text_field_error_message.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  static final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$');

  String _serverErrorText = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<bool> _isEmailValid = ValueNotifier(true);
  final ValueNotifier<bool> _isPasswordValid = ValueNotifier(true);

  final ValueNotifier<bool> _isEmailCorrect = ValueNotifier(true);
  final ValueNotifier<bool> _isPasswordCorrect = ValueNotifier(true);

  final ValueNotifier<bool> _isLoginCorrect = ValueNotifier(true);
  final ValueNotifier<bool> _isLoadingController = ValueNotifier(false);

  void _validateInputs() {
    final bool isEmailValid = emailRegex.hasMatch(_emailController.text) ||
        _emailController.text.isEmpty;
    final bool isPasswordValid = _passwordController.text.length >= 6 ||
        _passwordController.text.isEmpty;

    _isEmailValid.value = isEmailValid;
    _isPasswordValid.value = isPasswordValid;
    _isEmailCorrect.value = isEmailValid;
    _isPasswordCorrect.value = isPasswordValid;
    _isLoginCorrect.value = true;

    setState(() {});
  }

  void _login() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        _serverErrorText =
            'Нет подключения к интернету. Пожалуйста, проверьте ваше соединение.';
        _isLoadingController.value = false;
        _isEmailCorrect.value = false;
        _isPasswordCorrect.value = false;
        _isLoginCorrect.value = false;
      });
      return;
    }

    const androidIdPlugin = AndroidId();
    final String? androidId = await androidIdPlugin.getId();

    context.read<AuthBloc>().add(AuthEvent.login(
        _emailController.text, androidId!, _passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _isEmailValid.dispose();
    _isPasswordValid.dispose();
    _isEmailCorrect.dispose();
    _isPasswordCorrect.dispose();
    _isLoginCorrect.dispose();
    _isLoadingController.dispose();
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
                  "assets/icons/arrow_left.svg",
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
                    validateController: _isEmailCorrect,
                    onChanged: _validateInputs,
                  ),
                  TextFieldErrorMessage(
                    validator: _isEmailValid,
                    message: "Некорректный формат почты",
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: 'Пароль',
                    obscureText: true,
                    validateController: _isPasswordCorrect,
                    onChanged: _validateInputs,
                  ),
                  TextFieldErrorMessage(
                    validator: _isPasswordValid,
                    message: "Слишком короткий пароль",
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldErrorMessage(
                              validator: _isLoginCorrect,
                              message: _serverErrorText,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.h),
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
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
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                _isLoadingController.value = false;
              } else if (state is AuthFailure) {
                setState(() {
                  _serverErrorText = state.errorMessage;
                  _isLoadingController.value = false;
                  _isEmailCorrect.value = false;
                  _isPasswordCorrect.value = false;
                  _isLoginCorrect.value = false;
                });
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                _isLoadingController.value = true;
              }
              return CustomElevatedButton(
                text: 'Войти',
                isEnabled: _isEmailValid.value &&
                    _isPasswordValid.value &&
                    _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _isLoginCorrect.value,
                onPressed: _login,
                isLoadingController: _isLoadingController,
              );
            },
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
