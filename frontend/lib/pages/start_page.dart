import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/router/app_router.dart';
import '../ui_scaling.dart';
import '../widgets/custom_elevated_button.dart';

@RoutePage()
class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scaling = Scaling.of(context);

    return Scaffold(
      bottomNavigationBar: _buildActionButtons(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: scaling.scaleHeight(120)),
                    Image.asset("assets/images/Start_v1.png"),
                    SizedBox(height: scaling.scaleHeight(40)),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'В путь за ',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(fontSize: scaling.scaleWidth(32)),
                          ),
                          TextSpan(
                            text: 'лучшей',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontSize: scaling.scaleWidth(32)),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'версией себя',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(fontSize: scaling.scaleWidth(32)),
                    ),
                    SizedBox(height: scaling.scaleHeight(16)),
                    Text(
                      'Устанавливай цели и достигай их. Наше приложение '
                          'поможет тебе строить полезные привычки, напоминать '
                          'о них и анализировать твой прогресс.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: scaling.scaleWidth(14)),
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
    final scaling = Scaling.of(context);
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            text: 'Начать',
            isEnabled: true,
            onPressed: () {
              print(scaling.scaleWidth(1));
              context.router.navigate(SignUpRoute());
            },
          ),
          TextButton(
            onPressed: () {
              print(scaling.scaleHeight(1));
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
