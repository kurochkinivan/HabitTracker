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
class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  PasswordRecoveryPageState createState() => PasswordRecoveryPageState();
}

class PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  static final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$');

  final TextEditingController _emailController = TextEditingController();
  final ValueNotifier<bool> _isEmailValid = ValueNotifier(true);

  void _validateEmail() {
    final isValid = emailRegex.hasMatch(_emailController.text) ||
        _emailController.text.isEmpty;
    _isEmailValid.value = isValid;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _isEmailValid.dispose();
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
                  context.router.navigate(SignInRoute());
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
                    "Восстановление пароля",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: scaling.scaleWidth(26)),
                  ),
                  SizedBox(height: scaling.scaleHeight(8)),
                  Text(
                    "Введите свой email, и мы отправим "
                    "вам код для восстановления пароля.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: scaling.scaleWidth(14)),
                  ),
                  SizedBox(height: scaling.scaleHeight(24)),
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: 'E-mail',
                    obscureText: false,
                    validateController: _isEmailValid,
                    onChanged: _validateEmail,
                  ),
                  PasswordErrorMessage(
                    validator: _isEmailValid,
                    message: "Некорректный формат почты",
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
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            text: 'Отправить код',
            isEnabled: _isEmailValid.value && _emailController.text.isNotEmpty,
            onPressed: () {
              context.router.navigate(VerifyPasswordRecoveryRoute());
            },
          ),
          SizedBox(
            height: scaling.scaleHeight(32),
          ),
        ],
      ),
    );
  }
}
