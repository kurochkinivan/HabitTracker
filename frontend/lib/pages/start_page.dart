import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_tracker/router/app_router.dart';
import '../widgets/custom_elevated_button.dart';

@RoutePage()
class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildActionButtons(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centering the row
                      children: [
                        SvgPicture.asset(
                          "assets/images/logo.svg",
                          width: 28.w,
                          fit: BoxFit.contain,
                        ), // Replace with your desired icon
                        SizedBox(width: 8.w), // Space between icon and text
                        Text(
                          'Habit Tracker',
                          style: TextStyle(
                              fontSize: 24.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    Image.asset("assets/images/Start_v1.png"),
                    SizedBox(height: 40.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'В путь за ',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          TextSpan(
                            text: 'лучшей',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'версией себя',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Устанавливай цели и достигай их. Наше приложение '
                      'поможет тебе строить полезные привычки, напоминать '
                      'о них и анализировать твой прогресс.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            // Bottom buttons
          ],
        ),
      ),
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
            text: 'Начать',
            isEnabled: true,
            onPressed: () {
              context.router.navigate(SignUpRoute());
            },
          ),
          TextButton(
            onPressed: () {
              context.router.navigate(SignInRoute());
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
