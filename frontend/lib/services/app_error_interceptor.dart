import 'package:dio/dio.dart';
import '../models/app_error.dart';

class AppErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      handler.next(response);
    } else {
      _handleErrorResponse(response, handler as ErrorInterceptorHandler);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      _handleErrorResponse(err.response!, handler);
    } else {
      _handleNetworkError(err, handler);
    }
  }

  void _handleErrorResponse(
    Response response,
    ErrorInterceptorHandler handler,
  ) {
    try {
      final errorData = _parseResponseData(response.data);
      final appError = AppError.fromJson(errorData);

      handler.reject(DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: appError,
        type: DioExceptionType.badResponse,
        message: appError.userMessage,
      ));
    } catch (e, stackTrace) {
      final fallbackError = AppError(
        code: 'PARSE_ERROR',
        devMessage: 'Ошибка парсинга: ${e.toString()}',
        userMessage: 'Некорректный ответ сервера.',
        errMessage: stackTrace.toString(),
      );

      handler.reject(DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: fallbackError,
        type: DioExceptionType.unknown,
        message: fallbackError.userMessage,
      ));
    }
  }

  void _handleNetworkError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    final appError = AppError(
      code: _getErrorCode(err.type),
      devMessage: 'Сетевая ошибка: ${err.message}',
      userMessage: _getUserMessage(err.type),
      errMessage: err.stackTrace.toString(),
    );

    handler.reject(err.copyWith(
      error: appError,
      message: appError.userMessage,
    ));
  }

  Map<String, dynamic> _parseResponseData(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is String) return {'message': data};
    return {'unknown_data': data.toString()};
  }

  String _getErrorCode(DioExceptionType type) {
    return type.name.toUpperCase();
  }

  String _getUserMessage(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Превышено время ожидания.';
      case DioExceptionType.connectionError:
        return 'Ошибка подключения к серверу.';
      case DioExceptionType.badCertificate:
        return 'Ошибка безопасности соединения.';
      default:
        return 'Произошла сетевая ошибка.';
    }
  }
}
