import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../router/app_router.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/text_field_error_message.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  static final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$');

  String _serverErrorText = '';
  String _sendEmail = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<bool> _isNameValid = ValueNotifier(true);
  final ValueNotifier<bool> _isEmailValid = ValueNotifier(true);
  final ValueNotifier<bool> _isPasswordValid = ValueNotifier(true);

  final ValueNotifier<bool> _isNameCorrect = ValueNotifier(true);
  final ValueNotifier<bool> _isEmailCorrect = ValueNotifier(true);
  final ValueNotifier<bool> _isPasswordCorrect = ValueNotifier(true);

  final ValueNotifier<bool> _isRegisterCorrect = ValueNotifier(true);
  final ValueNotifier<bool> _isLoadingController = ValueNotifier(false);

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
    _isNameCorrect.value = isNameValid;
    _isEmailCorrect.value = isEmailValid;
    _isPasswordCorrect.value = isPasswordValid;
    _isRegisterCorrect.value = true;

    setState(() {});
  }

  void _register() async {
    _sendEmail = _emailController.text;
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        _serverErrorText =
            'Нет подключения к интернету. Пожалуйста, проверьте ваше соединение.';
        _isLoadingController.value = false;
        _isEmailCorrect.value = false;
        _isPasswordCorrect.value = false;
        _isRegisterCorrect.value = false;
      });
      return;
    }
    context.read<AuthBloc>().add(AuthEvent.register(
        _sendEmail, _nameController.text, _passwordController.text));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _isNameValid.dispose();
    _isEmailValid.dispose();
    _isPasswordValid.dispose();
    _isNameCorrect.dispose();
    _isEmailCorrect.dispose();
    _isPasswordCorrect.dispose();
    _isRegisterCorrect.dispose();
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
              padding: EdgeInsets.only(top: 64.h, left: 22.w),
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
                    validateController: _isNameCorrect,
                    onChanged: _validateInputs,
                  ),
                  TextFieldErrorMessage(
                    validator: _isNameValid,
                    message: "Слишком короткое имя",
                  ),
                  SizedBox(height: 10.h),
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
                  TextFieldErrorMessage(
                    validator: _isRegisterCorrect,
                    message: _serverErrorText,
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
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                _isLoadingController.value = false;
                context.router.push(
                  VerifyEmailRoute(email: _sendEmail),
                );
              } else if (state is AuthFailure) {
                setState(() {
                  _serverErrorText = state.errorMessage;
                  _isLoadingController.value = false;
                  _isNameCorrect.value = false;
                  _isEmailCorrect.value = false;
                  _isPasswordCorrect.value = false;
                  _isRegisterCorrect.value = false;
                });
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                _isLoadingController.value = true;
              }
              return CustomElevatedButton(
                onPressed: _register,
                text: 'Зарегистрироваться',
                isEnabled: _isNameValid.value &&
                    _isEmailValid.value &&
                    _isPasswordValid.value &&
                    _nameController.text.isNotEmpty &&
                    _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _isRegisterCorrect.value,
                isLoadingController: _isLoadingController,
              );
            },
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
