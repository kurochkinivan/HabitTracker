import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/add_habit_page.dart';
import 'package:habit_tracker/pages/habit_settings_page.dart';
import 'package:habit_tracker/pages/password_recovery_page.dart';
import '../pages/start_page.dart';
import '../pages/sign_up_page.dart';
import '../pages/sign_in_page.dart';
import '../pages/verify_email_page.dart';
import '../pages/verify_password_recovery_page.dart';
import '../pages/new_password_page.dart';
import '../pages/icon_choice_page.dart';
import '../pages/color_choice_page.dart';
import 'my_custom_transition.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
        transitionsBuilder: myCustomTransition,
        durationInMilliseconds: 250,
        reverseDurationInMilliseconds: 250,
      );

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartRoute.page, path: '/', initial: true),
        AutoRoute(page: SignInRoute.page, path: '/sign-in'),
        AutoRoute(page: SignUpRoute.page, path: '/sign-up'),
        AutoRoute(page: VerifyEmailRoute.page, path: '/verify-email'),
        AutoRoute(page: VerifyPasswordRecoveryRoute.page, path: '/verify-password-recovery'),
        AutoRoute(page: PasswordRecoveryRoute.page, path: '/password-recovery'),
        AutoRoute(page: NewPasswordRoute.page, path: '/new-password'),
        AutoRoute(page: AddHabitRoute.page, path: '/add-habit', ),
        AutoRoute(page: HabitSettingsRoute.page, path: '/habit-settings'),
        AutoRoute(page: IconChoiceRoute.page, path: '/icon-choice'),
        AutoRoute(page: ColorChoiceRoute.page, path: '/color-choice'),
      ];
}
