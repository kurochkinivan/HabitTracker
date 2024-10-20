// services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_models.dart';

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:8080/v1';

  // Регистрация пользователя
  Future<void> registerUser(RegisterRequest request) async {
    final url = Uri.parse('$baseUrl/auth/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()), // Преобразуем объект в JSON
    );

    if (response.statusCode == 201) {
      // Успешная регистрация
      print('User registered successfully');
    } else if (response.statusCode == 400) {
      // Некорректные данные
      print('Bad Request: ${response.body}');
    } else if (response.statusCode == 500) {
      // Ошибка сервера
      print('Server error: ${response.body}');
    } else {
      // Другие ошибки
      print('Error: ${response.statusCode} - ${response.body}');
    }
  }

  // Вход пользователя
  Future<LoginResponse?> loginUser(LoginRequest request) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()), // Преобразуем объект в JSON
    );

    if (response.statusCode == 200) {
      // Успешный вход, получаем JWT
      final Map<String, dynamic> json = jsonDecode(response.body);
      return LoginResponse.fromJson(json);
    } else if (response.statusCode == 401) {
      // Неверные учетные данные
      print('Unauthorized: Email or password is incorrect');
    } else if (response.statusCode == 400) {
      // Ошибка данных запроса
      print('Bad Request: ${response.body}');
    } else if (response.statusCode == 500) {
      // Ошибка сервера
      print('Server error: ${response.body}');
    } else {
      // Другие ошибки
      print('Error: ${response.statusCode} - ${response.body}');
    }
    return null;
  }
}
