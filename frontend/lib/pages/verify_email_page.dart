import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app_colors.dart';
import '../router/app_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/resend_code_button.dart';

@RoutePage()
class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  VerifyEmailPageState createState() => VerifyEmailPageState();
}

class VerifyEmailPageState extends State<VerifyEmailPage> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
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
                cursorColor: hasError ? AppColors.redError : AppColors.black01,
                cursorHeight: 64,
                keyboardType: TextInputType.number,
                autoDismissKeyboard: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: textEditingController,
                errorAnimationController: errorController,
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
                  selectedColor: hasError ? AppColors.red02 : AppColors.grey02,
                  activeFillColor: AppColors.black01,
                  activeColor: AppColors.black01,
                  errorBorderColor: AppColors.redError,
                  inactiveFillColor: AppColors.grey02,
                  inactiveColor: AppColors.grey02,
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
          CustomElevatedButton(
            text: 'Продолжить',
            isEnabled: textEditingController.text.isNotEmpty,
            onPressed: () {
              if (textEditingController.text != "1111") {
                errorController?.add(ErrorAnimationType.shake);
                setState(() {
                  hasError = true;
                });
              } else {
                setState(() {
                  hasError = false;
                });
                // Логика успешной проверки кода
              }
            },
          ),
          ResendCodeButton(textEditingController: textEditingController),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
