import 'package:flutter/material.dart';
import 'package:habit_tracker/router/app_router.dart';
import 'package:habit_tracker/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        title: 'Habbit Tracker',
        theme: habitTrackerTheme());
  }
}