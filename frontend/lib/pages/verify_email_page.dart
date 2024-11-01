import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../models/get_verification_code_request.dart';
import '../router/app_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/resend_code_button.dart';
import '../widgets/text_field_error_message.dart';

@RoutePage()
class VerifyEmailPage extends StatefulWidget {
  final String email;

  const VerifyEmailPage({super.key, required this.email});

  @override
  VerifyEmailPageState createState() => VerifyEmailPageState();
}

class VerifyEmailPageState extends State<VerifyEmailPage> {
  String _serverErrorText = '';

  StreamController<ErrorAnimationType>? _errorController;

  final TextEditingController _textEditingController = TextEditingController();

  final ValueNotifier<bool> _isSendCodeCorrect = ValueNotifier(true);
  final ValueNotifier<bool> _isLoadingController = ValueNotifier(false);

  void verifyEmail() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        _serverErrorText =
            'Нет подключения к интернету. Пожалуйста, проверьте ваше соединение.';
        _isLoadingController.value = false;
      });
      return;
    }

    context
        .read<AuthBloc>()
        .add(AuthEvent.verifyEmail(widget.email, _textEditingController.text));
  }

  void resendCode() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        _serverErrorText =
            'Нет подключения к интернету. Пожалуйста, проверьте ваше соединение.';
        _isLoadingController.value = false;
      });
      return;
    }

    context.read<AuthBloc>().add(AuthEvent.sendVerificationCode(widget.email));
  }

  @override
  void initState() {
    _errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    _errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(top: 64.h, left: 20),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/images/Arrow_left.svg",
              height: 32.w,
              width: 32.w,
              fit: BoxFit.contain,
            ),
            onPressed: () {
              context.router.navigate(SignUpRoute());
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Text("Подтвердите почту",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 26.sp)),
              SizedBox(height: 8.h),
              Text(
                  "Почти готово! Тебе выслан код на твой email,"
                  " активируй аккаунт и начинай строить новые привычки.",
                  style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 80.h),
              PinCodeTextField(
                appContext: context,
                length: 4,
                cursorColor: !_isSendCodeCorrect.value
                    ? AppColors.redError
                    : AppColors.black01,
                cursorHeight: 64,
                keyboardType: TextInputType.number,
                autoDismissKeyboard: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _textEditingController,
                errorAnimationController: _errorController,
                onChanged: (value) {
                  _isSendCodeCorrect.value = true;
                  setState(() {});
                },
                textStyle: TextStyle(
                  color: !_isSendCodeCorrect.value
                      ? AppColors.redError
                      : AppColors.black01,
                  fontSize: 64,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w500,
                ),
                pinTheme: PinTheme(
                  fieldWidth: 64,
                  fieldHeight: 80,
                  shape: PinCodeFieldShape.underline,
                  selectedFillColor: AppColors.black01,
                  selectedColor: !_isSendCodeCorrect.value
                      ? AppColors.red02
                      : AppColors.grey02,
                  activeFillColor: AppColors.black01,
                  activeColor: AppColors.black01,
                  errorBorderColor: AppColors.redError,
                  inactiveFillColor: AppColors.grey02,
                  inactiveColor: AppColors.grey02,
                ),
              ),
              Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 14.h),
                    child: TextFieldErrorMessage(
                      validator: _isSendCodeCorrect,
                      message: _serverErrorText,
                    )),
              ),
            ],
          ),
        ),
      ])),
      bottomNavigationBar: _buildActionButtons(context),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                _isSendCodeCorrect.value = true;
                _isLoadingController.value = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is AuthFailure) {
                _errorController?.add(ErrorAnimationType.shake);
                setState(() {
                  _isSendCodeCorrect.value = false;
                  _serverErrorText = state.errorMessage;
                  _isLoadingController.value = false;
                });
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                _isLoadingController.value = true;
              }
              return CustomElevatedButton(
                text: 'Продолжить',
                isEnabled: _textEditingController.text.length == 4 &&
                    _isSendCodeCorrect.value,
                onPressed: verifyEmail,
                isLoadingController: _isLoadingController,
              );
            },
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                _isSendCodeCorrect.value = true;
                _isLoadingController.value = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is AuthFailure) {
                _errorController?.add(ErrorAnimationType.shake);
                setState(() {
                  _isSendCodeCorrect.value = false;
                  _serverErrorText = state.errorMessage;
                  _isLoadingController.value = false;
                });
              }
            },
            builder: (context, state) {
              return ResendCodeButton(
                  textEditingController: _textEditingController);
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
