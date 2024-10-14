import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../app_colors.dart';
import '../router/app_router.dart';
import '../ui_scaling.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
    final scaling = Scaling.of(context);
    return Scaffold(
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              context.router.navigate(SignUpRoute());
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: scaling.scaleHeight(16)),
              Text("Подтвердите почту",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: scaling.scaleWidth(26))),
              SizedBox(height: scaling.scaleHeight(8)),
              Text(
                  "Почти готово! Тебе выслан код на твой email,"
                  " активируй аккаунт и начинай строить новые привычки.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: scaling.scaleWidth(14))),
              SizedBox(height: scaling.scaleWidth(80)),
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
                    padding: const EdgeInsets.only(top: 18),
                    child: Text(
                      "Код введен неправильно",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: scaling.scaleWidth(12)),
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
    final scaling = Scaling.of(context);
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
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
            child: Center(
              child: Text(
                'Продолжить',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: scaling.scaleWidth(14)),
              ),
            ),
          ),
          ResendCodeButton(textEditingController: textEditingController),
          SizedBox(
            height: scaling.scaleHeight(16),
          ),
        ],
      ),
    );
  }
}
