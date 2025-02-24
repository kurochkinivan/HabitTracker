import 'dart:convert';
import 'package:android_id/android_id.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/refresh_tokens_request.dart';
import 'api_client.dart';

class TokenInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;
  final ApiClient apiClient;

  TokenInterceptor({
    required this.secureStorage,
    required this.apiClient,
  });

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userId = sharedPrefs.getString('user_id');
    var accessToken = await secureStorage.read(key: 'access_token');

    if (accessToken == null || _isTokenExpired(accessToken)) {
      final refreshToken = await secureStorage.read(key: 'refresh_token');
      if (refreshToken == null || userId == null) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: "Отсутствуют данные для обновления токена",
          ),
        );
      }
      try {
        final androidIdPlugin = AndroidId();
        final androidId = await androidIdPlugin.getId();
        if (androidId == null) {
          return handler.reject(
            DioException(
              requestOptions: options,
              error: "Не удалось получить идентификатор устройства",
            ),
          );
        }
        final refreshResponse = await apiClient.refreshTokens(
          RefreshTokensRequest(
            fingerprint: androidId,
            refreshToken: refreshToken,
            userId: userId,
          ),
        );
        accessToken = refreshResponse.accessToken;
        await secureStorage.write(
            key: 'access_token', value: refreshResponse.accessToken);
        await secureStorage.write(
            key: 'refresh_token', value: refreshResponse.refreshToken);
      } catch (e) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: "Не удалось обновить токен",
          ),
        );
      }
    }

    if (accessToken != null) {
      options.headers["Authorization"] = "Bearer $accessToken";
    }
    handler.next(options);
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;
      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );
      final exp = payload['exp'];
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now()
          .add(const Duration(seconds: 15))
          .isAfter(expiryDate);
    } catch (_) {
      return true;
    }
  }
}
