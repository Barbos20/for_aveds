import 'package:flutter/material.dart';
import 'package:for_aveds/src/bll/auth_manager.dart';
import 'package:for_aveds/src/bll/auth_service.dart';

class LoginPage extends StatefulWidget {
  final AuthService authService;

  const LoginPage({required this.authService, super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late final AuthManager authManager;
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  String jwt = '';
  String rt = '';

  @override
  void initState() {
    super.initState();
    authManager = AuthManager(authService: widget.authService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await authManager.login(emailController.text);
              },
              child: const Text('Send Code'),
            ),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Code',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await authManager
                    .confirmCode(
                  emailController.text,
                  codeController.text,
                )
                    .then((token) {
                  setState(() {
                    jwt = token['jwt'] ?? '';
                  });
                });
              },
              child: const Text('Confirm Code'),
            ),
            Text(jwt.isNotEmpty ? 'Авторизован' : 'Не авторизован'),
          ],
        ),
      ),
    );
  }
}
