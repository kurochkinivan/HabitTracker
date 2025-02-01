import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../models/app_error.dart';

class AppLoggerInterceptor extends Interceptor {
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('🔹 [REQUEST] ${options.method} ${options.uri}');
    logger.d('Headers: ${options.headers}');
    if (options.data != null) {
      logger.d('Body: ${jsonEncode(options.data)}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(
        '✅ [RESPONSE] ${response.statusCode} ${response.requestOptions.uri}');

    final data = response.data;
    if (data is Map<String, dynamic> && data.containsKey('code')) {
      try {
        final appError = AppError.fromJson(data);
        logger.w('⚠️ Server responded with AppError: ${appError.toJson()}');
      } catch (_) {
        logger.d('Response: ${jsonEncode(data)}');
      }
    } else {
      logger.d('Response: ${jsonEncode(data)}');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('❌ [ERROR] ${err.type} - ${err.message}');

    if (err.error is AppError) {
      final appError = err.error as AppError;
      logger.e('🚨 AppError: ${appError.toJson()}');
    } else if (err.response?.data is Map<String, dynamic>) {
      try {
        final appError = AppError.fromJson(err.response!.data);
        logger.e('🚨 Parsed AppError: ${appError.toJson()}');
      } catch (_) {
        logger.e('Response Data: ${jsonEncode(err.response?.data)}');
      }
    } else {
      logger.e('Response Data: ${jsonEncode(err.response?.data)}');
    }

    handler.next(err);
  }
}
