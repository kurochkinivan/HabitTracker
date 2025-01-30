import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../router/app_router.dart';
import '../services/api_client.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/text_field_error_message.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final apiClient = ApiClient(dio, baseUrl: "http://10.0.2.2:8080/v1");

    return BlocProvider(
      create: (_) => AuthBloc(apiClient),
      child: const SignUpPageContent(),
    );
  }
}

class SignUpPageContent extends StatefulWidget {
  const SignUpPageContent({super.key});

  @override
  SignUpPageContentState createState() => SignUpPageContentState();
}

class SignUpPageContentState extends State<SignUpPageContent> {
  static final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+$');

  String _serverErrorText = '';
  String _sendEmail = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isNameValid = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isRegisterCorrect = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _validateInputs() {
    setState(() {
      _isNameValid =
          _nameController.text.length > 1 || _nameController.text.isEmpty;
      _isEmailValid = emailRegex.hasMatch(_emailController.text) ||
          _emailController.text.isEmpty;
      _isPasswordValid = _passwordController.text.length >= 6 ||
          _passwordController.text.isEmpty;
      _isRegisterCorrect = true;
    });
  }

  void _register() async {
    _sendEmail = _emailController.text;
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _serverErrorText =
            'Нет подключения к интернету. Пожалуйста, проверьте ваше соединение.';
        _isLoading = false;
        _isRegisterCorrect = false;
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
              const Spacer(),
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
                isValid: _isNameValid && _isRegisterCorrect,
                onChanged: _validateInputs,
              ),
              TextFieldErrorMessage(
                isValid: _isNameValid,
                message: "Слишком короткое имя",
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                controller: _emailController,
                hintText: 'E-mail',
                obscureText: false,
                isValid: _isEmailValid && _isRegisterCorrect,
                onChanged: _validateInputs,
              ),
              TextFieldErrorMessage(
                isValid: _isEmailValid,
                message: "Некорректный формат почты",
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                controller: _passwordController,
                hintText: 'Пароль',
                obscureText: true,
                isValid: _isPasswordValid && _isRegisterCorrect,
                onChanged: _validateInputs,
              ),
              TextFieldErrorMessage(
                isValid: _isPasswordValid,
                message: "Слишком короткий пароль",
              ),
              TextFieldErrorMessage(
                isValid: _isRegisterCorrect,
                message: _serverErrorText,
              ),
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
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Future.microtask(() {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                });
                context.router.push(
                  VerifyEmailRoute(email: _sendEmail),
                );
              } else if (state is AuthFailure) {
                Future.microtask(() {
                  if (mounted) {
                    setState(() {
                      _serverErrorText = state.errorMessage;

                      _isLoading = false;
                      _isRegisterCorrect = false;
                    });
                  }
                });
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                Future.microtask(() {
                  if (mounted) {
                    setState(() {
                      _isLoading = true;
                    });
                  }
                });
              }
              return CustomElevatedButton(
                onPressed: _register,
                text: 'Заре��истрироваться',
                isEnabled: _isNameValid &&
                    _isEmailValid &&
                    _isPasswordValid &&
                    _nameController.text.isNotEmpty &&
                    _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _isRegisterCorrect,
                isLoading: _isLoading,
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
