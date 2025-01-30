import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../router/app_router.dart';
import '../services/api_client.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/resend_code_button.dart';

@RoutePage()
class VerifyPasswordRecoveryPage extends StatelessWidget {
  const VerifyPasswordRecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final apiClient = ApiClient(dio, baseUrl: "http://10.0.2.2:8080/v1");

    return BlocProvider(
      create: (_) => AuthBloc(apiClient),
      child: const VerifyPasswordRecoveryPageContent(),
    );
  }
}
class VerifyPasswordRecoveryPageContent extends StatefulWidget {
  const VerifyPasswordRecoveryPageContent({super.key});

  @override
  VerifyPasswordRecoveryPageContentState createState() => VerifyPasswordRecoveryPageContentState();
}

class VerifyPasswordRecoveryPageContentState extends State<VerifyPasswordRecoveryPageContent> {
  final TextEditingController _textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? _errorController;

  bool hasError = false;

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
              Spacer(),
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
              Text("Код отправлен на почту",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 26.sp)),
              SizedBox(height: 8.h),
              Text(
                  "Если код не пришел, проверьте папку “Спам” "
                  "или нажмите “Отправить код повторно”.",
                  style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 80.h),
              PinCodeTextField(
                appContext: context,
                length: 4,
                cursorColor: hasError ? AppColors.redError : AppColors.black01,
                cursorHeight: 64,
                keyboardType: TextInputType.number,
                autoDismissKeyboard: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _textEditingController,
                errorAnimationController: _errorController,
                onChanged: (value) {
                  setState(() {
                    hasError = false;
                  });
                },
                textStyle: TextStyle(
                  color: hasError ? AppColors.redError : AppColors.black01,
                  fontSize: 64,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w500,
                ),
                pinTheme: PinTheme(
                  fieldWidth: 64,
                  fieldHeight: 80,
                  shape: PinCodeFieldShape.underline,
                  selectedFillColor: AppColors.black01,
                  selectedColor: hasError ? AppColors.red02 : AppColors.gray02,
                  activeFillColor: AppColors.black01,
                  activeColor: AppColors.black01,
                  errorBorderColor: AppColors.redError,
                  inactiveFillColor: AppColors.gray02,
                  inactiveColor: AppColors.gray02,
                ),
              ),
              if (hasError)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 18.h),
                    child: Text(
                      "Код введен неправильно",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
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
          CustomElevatedButton(
            text: 'Продолжить',
            isEnabled: _textEditingController.text.isNotEmpty,
            onPressed: () {
              if (_textEditingController.text != "1111") {
                _errorController?.add(ErrorAnimationType.shake);
                setState(() {
                  hasError = true;
                });
              } else {
                setState(() {
                  hasError = false;
                });
                context.router.navigate(NewPasswordRoute());
                // Логика успешной проверки кода
              }
            },
          ),
          ResendCodeButton(textEditingController: _textEditingController),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
