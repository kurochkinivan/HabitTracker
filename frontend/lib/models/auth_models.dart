// models/auth_models.dart

// Модель для запроса на регистрацию
class RegisterRequest {
  final String email;
  final String name;
  final String password;

  RegisterRequest({
    required this.email,
    required this.name,
    required this.password,
  });

  // Конвертация объекта в JSON для отправки на сервер
  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'password': password,
  };
}

// Модель для запроса на вход
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  // Конвертация объекта в JSON
  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}

// Модель для ответа при входе
class LoginResponse {
  final String jwt;

  LoginResponse({required this.jwt});

  // Создаем объект LoginResponse из JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(jwt: json['jwt']);
  }
}
