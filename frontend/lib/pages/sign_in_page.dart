import 'package:android_id/android_id.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker/app_colors.dart';
import 'package:habit_tracker/bloc/authentication/authentication_event.dart';
import '../bloc/authentication/authentication_bloc.dart';
import '../bloc/authentication/authentication_state.dart';
import '../router/app_router.dart';
import '../router/navigation_service.dart';
import '../services/api_client.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/text_field_error_message.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClient = RepositoryProvider.of<ApiClient>(context);
    return BlocProvider(
      create: (_) => AuthenticationBloc(apiClient: apiClient),
      child: const SignInPageContent(),
    );
  }
}

class SignInPageContent extends StatefulWidget {
  const SignInPageContent({super.key});

  @override
  SignInPageContentState createState() => SignInPageContentState();
}

class SignInPageContentState extends State<SignInPageContent> {
  static final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+$');

  String _serverErrorText = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isLoginCorrect = true;

  @override
  void initState() {
    super.initState();
  }

  void _validateInputs() {
    setState(() {
      _isEmailValid = emailRegex.hasMatch(_emailController.text) ||
          _emailController.text.isEmpty;
      _isPasswordValid = _passwordController.text.length >= 6 ||
          _passwordController.text.isEmpty;
      _isLoginCorrect = true;
    });
  }

  void _login() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      if (!mounted) return;
      setState(() {
        _serverErrorText =
            'Нет подключения к интернету. Пожалуйста, проверьте ваше соединение.';
        _isLoginCorrect = false;
      });
      return;
    }

    const androidIdPlugin = AndroidId();
    final String? androidId = await androidIdPlugin.getId();

    if (!mounted) return;
    context.read<AuthenticationBloc>().add(AuthenticationEvent.login(
        email: _emailController.text,
        fingerprint: androidId!,
        password: _passwordController.text));
  }

  @override
  void dispose() {
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
                  NavigationService().back(context);
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
                "Вход",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 26.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                "С возвращением! Продолжай улучшать свои привычки "
                "— каждый шаг важен на пути к успеху.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 24.h),
              CustomTextFormField(
                controller: _emailController,
                hintText: 'E-mail',
                obscureText: false,
                isValid: _isEmailValid && _isLoginCorrect,
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
                isValid: _isPasswordValid && _isLoginCorrect,
                onChanged: _validateInputs,
              ),
              TextFieldErrorMessage(
                isValid: _isPasswordValid,
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
                          isValid: _isLoginCorrect,
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
          BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              state.when(
                initial: () {},
                loading: () {},
                authenticated: (message) {
                  if (!(ModalRoute.of(context)?.isCurrent ?? false)) {
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                },
                failure: (errorMessage) {
                  setState(() {
                    _serverErrorText = errorMessage;
                    _isLoginCorrect = false;
                  });
                },
                authChecked: (_) {},
              );
            },
            builder: (context, state) {
              bool isLoading = false;
              state.maybeWhen(
                loading: () {
                  isLoading = true;
                },
                orElse: () {},
              );
              return CustomElevatedButton(
                text: 'Войти',
                isEnabled: _isEmailValid &&
                    _isPasswordValid &&
                    _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _isLoginCorrect,
                onPressed: _login,
                isLoading: isLoading,
              );
            },
          ),
          SizedBox(height: 12.h),
          OutlinedButton(
            onPressed: () {},
            child: Center(
              child: Text(
                'Войти через Google',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 14.sp, color: AppColors.black01),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              NavigationService().navigate(context, SignUpRoute());
            },
            child: Text(
              'У меня еще нет аккаунта',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
