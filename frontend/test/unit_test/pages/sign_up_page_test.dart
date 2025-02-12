import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/pages/sign_up_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/services/api_client.dart';

@visibleForTesting
void main() {
  group('SignUpPage', () {
    late ApiClient apiClient;
    final dio = Dio();
    setUp(() {
      apiClient = ApiClient(dio, baseUrl: "http://10.0.2.2:8080/v1");
    });

    testWidgets('renders SignUpPage', (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: RepositoryProvider.value(
              value: apiClient,
              child: const SignUpPage(),
            ),
          ),
        ),
      );

      expect(find.text('Регистрация'), findsOneWidget);
      expect(find.text('Имя'), findsOneWidget);
      expect(find.text('E-mail'), findsOneWidget);
      expect(find.text('Пароль'), findsOneWidget);
    });

    testWidgets('validates inputs correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: RepositoryProvider.value(
              value: apiClient,
              child: const SignUpPage(),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'A');
      await tester.enterText(find.byType(TextFormField).at(1), 'invalid-email');
      await tester.enterText(find.byType(TextFormField).at(2), '12345');

      await tester.tap(find.text('Зарегистрироваться'));
      await tester.pump();

      expect(find.text('Слишком короткое имя'), findsOneWidget);
      expect(find.text('Некорректный формат почты'), findsOneWidget);
      expect(find.text('Слишком короткий пароль'), findsOneWidget);
    });

    testWidgets('registers successfully with valid inputs', (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: RepositoryProvider.value(
              value: apiClient,
              child: const SignUpPage(),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'Vdd');
      await tester.enterText(find.byType(TextFormField).at(1), 'valid@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'validpassword');

      await tester.tap(find.text('Зарегистрироваться'));
      await tester.pump();

    });
  });
}
