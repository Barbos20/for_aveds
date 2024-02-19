import 'package:flutter/material.dart';
import 'package:for_aveds/src/bll/auth_service.dart';
import 'package:for_aveds/src/ui/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(
        authService: AuthService(),
      ),
    );
  }
}
