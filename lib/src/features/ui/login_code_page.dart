import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_aveds/src/features/bll/auth_manager.dart';
import 'package:for_aveds/src/features/bll/auth_service.dart';
import 'package:for_aveds/src/features/ui/succeeded_login.dart';
import 'package:for_aveds/src/theme/text_theme.dart';

class LoginCodePage extends StatefulWidget {
  final AuthService authService;
  final String email;

  const LoginCodePage({
    required this.email,
    required this.authService,
    super.key,
  });

  @override
  LoginCodePageState createState() => LoginCodePageState();
}

class LoginCodePageState extends State<LoginCodePage> {
  late final AuthManager authManager;
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  String jwt = '';

  @override
  void initState() {
    super.initState();
    authManager = AuthManager(authService: widget.authService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: _appBar(),
        backgroundColor: const Color.fromRGBO(229, 229, 229, 0.3),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(225, 225, 225, 0.3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(55),
                bottomRight: Radius.circular(55),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                child: Image.asset(
                  'assets/images/png/OnlineShopping.png',
                  height: 250,
                  width: 270,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Enter the code received',
                      style: textTheme.titleMedium,
                    ),
                    Column(
                      children: [
                        TextField(
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          controller: codeController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 15,
                              top: 1,
                              right: 15,
                              bottom: 1,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: 'Code',
                            labelStyle: textTheme.labelSmall,
                          ),
                          style: textTheme.labelSmall,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (value) async {
                            var result = await authManager.confirmCode(
                              widget.email,
                              codeController.text,
                            );
                            String jwtToken = result['jwt'] ?? '';
                            if (mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SucceededLogin(
                                          authService: widget.authService,
                                          email: widget.email,
                                          jwt: jwtToken,
                                        )),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        var result = await authManager.confirmCode(
                          widget.email,
                          codeController.text,
                        );
                        String jwtToken = result['jwt'] ?? '';
                        if (result.isNotEmpty && mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SucceededLogin(
                                email: widget.email,
                                authService: widget.authService,
                                jwt: jwtToken,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(242, 121, 107, 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 0,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Send code',
                              style: textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            indent: 20,
                            endIndent: 10,
                            color: Color.fromRGBO(163, 151, 151, 1),
                            height: 1,
                          ),
                        ),
                        Text(
                          'Or Login with',
                          style: textTheme.labelSmall,
                        ),
                        const Expanded(
                          child: Divider(
                            indent: 10,
                            endIndent: 20,
                            color: Color.fromRGBO(163, 151, 151, 1),
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/svg/google.svg',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Google',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You Don`t have an account ?',
                          style: textTheme.labelMedium,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Sign up',
                          style: textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Login',
              style: textTheme.displayMedium,
            ),
            const SizedBox(
              width: 5,
            ),
            SvgPicture.asset('assets/images/svg/User.svg'),
          ],
        ),
        Row(
          children: [
            if (jwt.isNotEmpty)
              Text(
                'Welcome back , ${widget.email}',
                style: textTheme.displaySmall,
              ),
          ],
        )
      ],
    );
  }
}
