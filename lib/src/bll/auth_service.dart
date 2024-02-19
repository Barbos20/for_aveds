import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, String>> login(String email) async {
    var response = await http.post(
      Uri.parse('https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/login'),
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String rt = data['rt'] ?? '';
      String jwt = data['jwt'] ?? '';
      return {'rt': rt, 'jwt': jwt};
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, String>> confirmCode(String email, String code) async {
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
      String rt = data['rt'] ?? '';
      String jwt = data['jwt'] ?? '';
      return {'rt': rt, 'jwt': jwt};
    } else {
      throw Exception('Failed to confirm code');
    }
  }

  Future<String> refreshToken(String rt) async {
    var response = await http.post(
      Uri.parse(
          'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/refresh_token'),
      body: jsonEncode(<String, String>{
        'token': rt,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['jwt'];
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}
