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

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartRoute.page,),
        AutoRoute(page: SignInRoute.page,),
        AutoRoute(page: SignUpRoute.page,),
        AutoRoute(page: VerifyEmailRoute.page),
        AutoRoute(page: VerifyPasswordRecoveryRoute.page),
        AutoRoute(page: PasswordRecoveryRoute.page),
        AutoRoute(page: NewPasswordRoute.page, ),
        AutoRoute(page: AddHabitRoute.page, path: '/', initial: true),
        AutoRoute(page: HabitSettingsRoute.page, ),
        AutoRoute(page: IconChoiceRoute.page, ),
        AutoRoute(page: ColorChoiceRoute.page, ),
      ];
}
