import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:habit_tracker/models/logout_request.dart';
import 'package:habit_tracker/models/refresh_tokens_request.dart';
import 'package:habit_tracker/models/verify_email_request.dart';
import 'package:retrofit/retrofit.dart';
import '../models/check_auth_response.dart';
import '../models/get_jwt_response.dart';
import '../models/get_verification_code_request.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import 'app_error_interceptor.dart';
import 'app_logger_interceptor.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8080/v1")
abstract class ApiClient {
  factory ApiClient(Dio dio, {required String baseUrl}) {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'X-Content-Type-Options': 'nosniff',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    dio.interceptors.addAll([
      if (kDebugMode) AppLoggerInterceptor(),
      AppErrorInterceptor(),
    ]);

    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @POST("/auth/register")
  Future<void> registerUser(@Body() RegisterRequest request);

  @POST("/auth/login")
  Future<GetJwtResponse> loginUser(@Body() LoginRequest request);

  @POST("/auth/get-verification-code")
  Future<void> getVerificationCode(@Body() GetVerificationCodeRequest request);

  @POST("/auth/verify-email")
  Future<GetJwtResponse> verifyEmail(@Body() VerifyEmailRequest request);

  @POST("/auth/refresh-tokens")
  Future<GetJwtResponse> refreshTokens(@Body() RefreshTokensRequest request);

  @GET("/auth/check-auth")
  Future<CheckAuthResponse> checkAuth(
      @Header("Authorization") String authorization);

  @POST("/auth/logout")
  Future<GetJwtResponse> logout(@Body() LogoutRequest request);
}
