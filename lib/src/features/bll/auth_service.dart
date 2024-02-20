import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  String? errorMessage;

  Future<Map<String, String>> login(String email) async {
    try {
      var response = await http.post(
        Uri.parse('https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/login'),
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      var data = response.statusCode == 200 ? jsonDecode(response.body) : null;
      String rt = data?['refresh_token'] ?? '';
      String jwt = data?['jwt'] ?? '';
      if (data == null) {
        errorMessage = 'Ошибка ${response.statusCode}';
      }
      return {'refresh_token': rt, 'jwt': jwt};
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, String>> confirmCode(String email, String code) async {
    try {
      var response = await http.post(
        Uri.parse(
            'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/confirm_code'),
        body: jsonEncode(<String, String>{
          'email': email,
          'code': code,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String rt = data['refresh_token'] ?? '';
        String jwt = data['jwt'] ?? '';
        return {'refresh_token': rt, 'jwt': jwt};
      } else {
        errorMessage = 'Ошибка ${response.statusCode}';
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  Future<String> refreshToken(String rt) async {
    var response = await http.post(
      Uri.parse(
          'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/refresh_token'),
      body: jsonEncode(<String, String>{
        'refresh_token': rt,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String newJwt = data['jwt'];

      Future.delayed(const Duration(seconds: 3500), () {
        refreshToken(rt);
      });

      return newJwt;
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}
