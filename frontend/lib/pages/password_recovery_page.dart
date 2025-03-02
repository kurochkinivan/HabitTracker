import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../router/app_router.dart';
import '../router/navigation_service.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/text_field_error_message.dart';

@RoutePage()
class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  static final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+$');

  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = true;

  void _validateEmail() {
    setState(() {
      _isEmailValid = emailRegex.hasMatch(_emailController.text) ||
          _emailController.text.isEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                "Восстановление пароля",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 26.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                "Введите свой email, и мы отправим "
                "вам код для восстановления пароля.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 24.h),
              CustomTextFormField(
                controller: _emailController,
                hintText: 'E-mail',
                obscureText: false,
                isValid: _isEmailValid,
                onChanged: _validateEmail,
              ),
              TextFieldErrorMessage(
                isValid: _isEmailValid,
                message: "Некорректный формат почты",
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
          CustomElevatedButton(
            text: 'Отправить код',
            isEnabled: _isEmailValid && _emailController.text.isNotEmpty,
            onPressed: () {
              NavigationService()
                  .navigate(context, VerifyPasswordRecoveryRoute());
            },
          ),
          SizedBox(
            height: 32.h,
          ),
        ],
      ),
    );
  }
}
