import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/bloc/registration/registration_bloc.dart';
import 'package:habit_tracker/bloc/registration/registration_event.dart';
import 'package:habit_tracker/widgets/custom_app_bar.dart';
import '../app_colors.dart';
import '../bloc/registration/registration_state.dart';
import '../models/registration_action_type.dart';
import '../router/app_router.dart';
import '../router/navigation_service.dart';
import '../services/api_client.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/text_field_error_message.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClient = RepositoryProvider.of<ApiClient>(context);

    return BlocProvider(
      create: (_) => RegistrationBloc(apiClient: apiClient),
      child: const SignUpPageContent(),
    );
  }
}

class SignUpPageContent extends StatefulWidget {
  const SignUpPageContent({super.key});

  @override
  State<SignUpPageContent> createState() => _SignUpPageContentState();
}

class _SignUpPageContentState extends State<SignUpPageContent> {
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
    if (connectivityResult.contains(ConnectivityResult.none)) {
      if (!mounted) return;
      setState(() {
        _serverErrorText =
            'Нет подключения к интернету. Пожалуйста, проверьте ваше соединение.';
        _isRegisterCorrect = false;
      });
      return;
    }

    if (!mounted) return;
    context.read<RegistrationBloc>().add(RegistrationEvent.register(
        email: _sendEmail,
        name: _nameController.text,
        password: _passwordController.text));
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
      appBar: CustomAppBar(onPressed: () => NavigationService().back(context)),
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
                  "Присоединяйся к сообществу, где каждый шаг "
                  "приближает тебя к лучшей цели!",
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
          BlocConsumer<RegistrationBloc, RegistrationState>(
            listenWhen: (previous, current) {
              return current.when(
                initial: () => false,
                loading: (action) => action == RegistrationActionType.register,
                success: (message, action) =>
                    action == RegistrationActionType.register,
                failure: (errorMessage, action) =>
                    action == RegistrationActionType.register,
              );
            },
            buildWhen: (previous, current) {
              return current.when(
                initial: () => true,
                loading: (action) => action == RegistrationActionType.register,
                success: (message, action) =>
                    action == RegistrationActionType.register,
                failure: (errorMessage, action) =>
                    action == RegistrationActionType.register,
              );
            },
            listener: (context, state) {
              state.whenOrNull(
                loading: (action) {},
                success: (message, action) {
                  if (!(ModalRoute.of(context)?.isCurrent ?? false)) {
                    return;
                  }
                  context.router.push(VerifyEmailRoute(email: _sendEmail));
                },
                failure: (errorMessage, action) {
                  setState(() {
                    _serverErrorText = errorMessage;
                    _isRegisterCorrect = false;
                  });
                },
              );
            },
            builder: (context, state) {
              bool isLoading = false;
              state.maybeWhen(
                loading: (action) {
                  isLoading = true;
                },
                orElse: () {},
              );
              return CustomElevatedButton(
                onPressed: _register,
                text: 'Зарегистрироваться',
                isEnabled: _isNameValid &&
                    _isEmailValid &&
                    _isPasswordValid &&
                    _nameController.text.isNotEmpty &&
                    _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _isRegisterCorrect,
                isLoading: isLoading,
              );
            },
          ),
          SizedBox(height: 12.h),
          OutlinedButton(
            onPressed: () {},
            child: Center(
              child: Text(
                'Зарегистрироваться через Google',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 14.sp, color: AppColors.black01),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              NavigationService().navigate(context, SignInRoute());
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
