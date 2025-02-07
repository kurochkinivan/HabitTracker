import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/router/app_router.dart';
import 'package:habit_tracker/services/api_client.dart';
import 'package:habit_tracker/theme.dart';

void main() {
  final dio = Dio();
  final apiClient = ApiClient(dio, baseUrl: "http://10.0.2.2:8080/v1");

  final appRouter = AppRouter();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiClient>.value(value: apiClient),
      ],
      child: MyApp(appRouter: appRouter),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
          title: 'Habit Tracker',
          theme: habitTrackerTheme(),
        );
      },
    );
  }
}
