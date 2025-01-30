import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/router/app_router.dart';
import 'package:habit_tracker/services/api_client.dart';
import 'package:habit_tracker/theme.dart';
import 'bloc/auth_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final apiClient = ApiClient(dio, baseUrl: "http://10.0.2.2:8080/v1");

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => AuthBloc(apiClient),
          child: MaterialApp.router(
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            debugShowCheckedModeBanner: false,
            title: 'Habit Tracker',
            theme: habitTrackerTheme(),
          ),
        );
      },
    );
  }
}
