import 'dart:async';
import 'package:android_id/android_id.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../bloc/registration/registration_bloc.dart';
import '../bloc/registration/registration_event.dart';
import '../bloc/registration/registration_state.dart';
import '../models/registration_action_type.dart';
import '../router/navigation_service.dart';
import '../services/api_client.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/resend_code_button.dart';
import '../widgets/text_field_error_message.dart';

@RoutePage()
class VerifyEmailPage extends StatelessWidget {
  final String email;

  const VerifyEmailPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final apiClient = RepositoryProvider.of<ApiClient>(context);

    return BlocProvider(
      create: (_) => RegistrationBloc(apiClient: apiClient),
      child: VerifyEmailPageContent(email: email),
    );
  }
}

class VerifyEmailPageContent extends StatefulWidget {
  final String email;

  const VerifyEmailPageContent({super.key, required this.email});

  @override
  State<VerifyEmailPageContent> createState() => _VerifyEmailPageContentState();
}

class _VerifyEmailPageContentState extends State<VerifyEmailPageContent> {
  String _serverErrorText = '';
  bool _isSendCodeCorrect = true;

  StreamController<ErrorAnimationType>? _errorController;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    _errorController?.close();
    _textEditingController.dispose();
    super.dispose();
  }

  void _verifyEmail() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      if (!mounted) return;
      setState(() {
        _serverErrorText =
            'Нет подключения к интернету. Пожалуйста, проверьте ваше соединение.';
      });
      return;
    }

    const androidIdPlugin = AndroidId();
    final String? androidId = await androidIdPlugin.getId();

    if (!mounted) return;
    context.read<RegistrationBloc>().add(RegistrationEvent.verifyEmail(
          code: _textEditingController.text,
          email: widget.email,
          fingerprint: androidId!,
        ));
  }

  void _resendCode() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      if (!mounted) return;
      setState(() {
        _serverErrorText =
            'Нет подключения к интернету. Пожалуйста, проверьте ваше соединение.';
        return;
      });
    }

    if (!mounted) return;
    context.read<RegistrationBloc>().add(RegistrationEvent.getVerificationCode(
          email: widget.email,
        ));
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
                "Код отправлен на почту",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 26.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                "Почти готово! Тебе выслан код "
                "на ${widget.email.replaceAllMapped(RegExp(r'^(.{2}).*?(?=@)'), (match) => '${match[1]}***')}, "
                "активируй аккаунт и начинай строить новые привычки.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 80.h),
              PinCodeTextField(
                appContext: context,
                length: 4,
                cursorColor:
                    _isSendCodeCorrect ? AppColors.black01 : AppColors.redError,
                cursorHeight: 64,
                keyboardType: TextInputType.number,
                autoDismissKeyboard: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _textEditingController,
                errorAnimationController: _errorController,
                onChanged: (value) {
                  setState(() {
                    _isSendCodeCorrect = true;
                  });
                },
                textStyle: TextStyle(
                  color: _isSendCodeCorrect
                      ? AppColors.black01
                      : AppColors.redError,
                  fontSize: 64,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w500,
                ),
                pinTheme: PinTheme(
                  fieldWidth: 64,
                  fieldHeight: 80,
                  shape: PinCodeFieldShape.underline,
                  selectedFillColor: AppColors.black01,
                  selectedColor:
                      _isSendCodeCorrect ? AppColors.gray02 : AppColors.red02,
                  activeFillColor: AppColors.black01,
                  activeColor: AppColors.black01,
                  errorBorderColor: AppColors.redError,
                  inactiveFillColor: AppColors.gray02,
                  inactiveColor: AppColors.gray02,
                ),
              ),
              Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 14.h),
                    child: TextFieldErrorMessage(
                      isValid: _isSendCodeCorrect,
                      message: _serverErrorText,
                    )),
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
                loading: (action) =>
                    action == RegistrationActionType.verifyEmail,
                success: (message, action) =>
                    action == RegistrationActionType.verifyEmail,
                failure: (errorMessage, action) =>
                    action == RegistrationActionType.verifyEmail,
              );
            },
            buildWhen: (previous, current) {
              return current.when(
                initial: () => false,
                loading: (action) =>
                    action == RegistrationActionType.verifyEmail,
                success: (message, action) =>
                    action == RegistrationActionType.verifyEmail,
                failure: (errorMessage, action) =>
                    action == RegistrationActionType.verifyEmail,
              );
            },
            listener: (context, state) {
              state.whenOrNull(
                loading: (action) {},
                success: (message, action) {
                  setState(() {
                    _isSendCodeCorrect = true;
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                },
                failure: (errorMessage, action) {
                  _errorController?.add(ErrorAnimationType.shake);
                  setState(() {
                    _serverErrorText = errorMessage;
                    _isSendCodeCorrect = false;
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
                text: 'Продолжить',
                isEnabled: _textEditingController.text.length == 4 &&
                    _isSendCodeCorrect,
                onPressed: _verifyEmail,
                isLoading: isLoading,
              );
            },
          ),
          BlocConsumer<RegistrationBloc, RegistrationState>(
            listenWhen: (previous, current) {
              return current.when(
                initial: () => false,
                loading: (action) =>
                    action == RegistrationActionType.getVerificationCode,
                success: (message, action) =>
                    action == RegistrationActionType.getVerificationCode,
                failure: (errorMessage, action) =>
                    action == RegistrationActionType.getVerificationCode,
              );
            },
            buildWhen: (previous, current) {
              return true;
            },
            listener: (context, state) {
              state.whenOrNull(
                success: (message, action) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                },
                failure: (errorMessage, action) {
                  _errorController?.add(ErrorAnimationType.shake);
                  setState(() {
                    _serverErrorText = errorMessage;
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(errorMessage)));
                },
              );
            },
            builder: (context, state) {
              return ResendCodeButton(
                onPressed: _resendCode,
                textEditingController: _textEditingController,
              );
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
