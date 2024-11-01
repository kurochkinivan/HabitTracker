import 'package:dio/dio.dart';

import '../models/app_error.dart';

class AppErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      handler.next(response);
    } else {
      super.onResponse(response, handler);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null && err.response?.data is Map<String, dynamic>) {
      try {
        final appError = AppError.fromJson(err.response?.data);
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: appError,
          type: err.type,
        ));
      } catch (_) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }
}
