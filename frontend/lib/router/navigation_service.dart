import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  void navigate(BuildContext context, PageRouteInfo route) {
    final router = context.router;

    bool isRouteInStack = router.stack.any((r) => r.name == route.routeName);

    if (isRouteInStack) {
      router.removeWhere((r) => r.name == route.routeName);
    }

    router.push(route);
  }

  void back(BuildContext context) {
    final router = context.router;

    if (router.canPop()) {
      router.maybePop();
    } else {
      router.popUntilRoot();
    }
  }
}
