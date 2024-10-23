import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';
import '../router/app_router.dart';
import '../ui_scaling.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field_widget.dart';
import '../widgets/password_error_message_widget.dart';

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
                onPressed: () {
                  context.router.navigate(StartRoute());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: scaling.scaleHeight(16)),
                  Text(
                    "Регистрация",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: scaling.scaleWidth(26)),
                  ),
                  SizedBox(height: scaling.scaleHeight(8)),
                  Text(
                    "Присоединяйся к сообществу, где каждый шаг "
                    "приближает тебя к лучшей цели!",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: scaling.scaleWidth(14)),
                  ),
                  SizedBox(height: scaling.scaleHeight(24)),
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
                  SizedBox(height: scaling.scaleHeight(10)),
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
                  SizedBox(height: scaling.scaleHeight(10)),
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
    final scaling = Scaling.of(context);

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 32),
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
            onPressed: () {
              context.router.navigate(VerifyEmailRoute());
            },
          ),
          SizedBox(height: scaling.scaleHeight(12)),
          OutlinedButton(
            onPressed: () {},
            child: Center(
              child: Text(
                'Зарегистрироваться с помощью Google',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: scaling.scaleWidth(14), color: AppColors.black01),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.router.navigate(SignInRoute());
            },
            child: Text(
              'У меня уже есть аккаунт',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: scaling.scaleWidth(14)),
            ),
          ),
          SizedBox(
            height: scaling.scaleHeight(16),
          ),
        ],
      ),
    );
  }
}

