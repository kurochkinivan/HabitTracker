import 'dart:async';
import 'package:android_id/android_id.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../services/api_client.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/resend_code_button.dart';
import '../widgets/text_field_error_message.dart';

@RoutePage()
class VerifyEmailPage extends StatelessWidget {
  final String email;

  const VerifyEmailPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final apiClient = ApiClient(dio, baseUrl: "http://10.0.2.2:8080/v1");

    return BlocProvider(
      create: (_) => AuthBloc(apiClient),
      child: VerifyEmailPageContent(email: email),
    );
  }
}

class VerifyEmailPageContent extends StatefulWidget {
  final String email;

  const VerifyEmailPageContent({super.key, required this.email});

  @override
  VerifyEmailPageContentState createState() => VerifyEmailPageContentState();
}

class VerifyEmailPageContentState extends State<VerifyEmailPageContent> {
  String _serverErrorText = '';
  bool _isSendCodeCorrect = true;
  bool _isLoading = false;

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
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _serverErrorText =
            'Нет подключения к интернету. Пожалуйста, проверьте ваше соединение.';
        _isLoading = false;
      });
      return;
    }

    const androidIdPlugin = AndroidId();
    final String? androidId = await androidIdPlugin.getId();
    context.read<AuthBloc>().add(AuthEvent.verifyEmail(
        _textEditingController.text, widget.email, androidId!));
  }

  void _resendCode() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _serverErrorText =
            'Нет подключения к интернету. Пожалуйста, проверьте ваше соединение.';
        return;
      });
    }

    context.read<AuthBloc>().add(AuthEvent.getVerificationCode(widget.email));
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
          padding: EdgeInsets.only(left: 8.w, right: 32.w),
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
                "Код отправлен на почту",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 26.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                "Если код не пришел, проверьте папку “Спам” или нажмите “Отправить код повторно”.",
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

  // переделать блок
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
                      _isSendCodeCorrect = true;
                    });
                  }
                });
              } else if (state is AuthFailure) {
                Future.microtask(() {
                  if (mounted) {
                    _errorController?.add(ErrorAnimationType.shake);
                    setState(() {
                      _serverErrorText = state.errorMessage;
                      _isLoading = false;
                      _isSendCodeCorrect = false;
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
                text: 'Продолжить',
                isEnabled: _textEditingController.text.length == 4 &&
                    _isSendCodeCorrect,
                onPressed: _verifyEmail,
                isLoading: _isLoading,
              );
            },
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                if (mounted) {
                  setState(() {
                    _isSendCodeCorrect = true;
                    _isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              } else if (state is AuthFailure) {
                if (mounted) {
                  setState(() {
                    _isSendCodeCorrect = false;
                    _serverErrorText = state.errorMessage;
                    _isLoading = false;
                  });
                  _errorController?.add(ErrorAnimationType.shake);
                }
              }
            },
            builder: (context, state) {
              return ResendCodeButton(
                  onPressed: _resendCode,
                  textEditingController: _textEditingController);
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
