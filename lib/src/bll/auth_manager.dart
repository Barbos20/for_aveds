import 'auth_service.dart';

class AuthManager {
  final AuthService authService;

  AuthManager({required this.authService});

  Future<Map<String, String>> login(String email) async {
    try {
      var tokens = await authService.login(email);
      return tokens;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, String>> confirmCode(String email, String code) async {
    try {
      var tokens = await authService.confirmCode(email, code);
      return tokens;
    } catch (e) {
      rethrow;
    }
  }
}
