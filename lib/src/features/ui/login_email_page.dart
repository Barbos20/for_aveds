import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_aveds/src/features/bll/auth_manager.dart';
import 'package:for_aveds/src/features/bll/auth_service.dart';
import 'package:for_aveds/src/features/ui/login_code_page.dart';
import 'package:for_aveds/src/theme/text_theme.dart';

class LoginEmailPage extends StatefulWidget {
  final AuthService authService;

  const LoginEmailPage({required this.authService, super.key});

  @override
  LoginEmailPageState createState() => LoginEmailPageState();
}

class LoginEmailPageState extends State<LoginEmailPage> {
  late final AuthManager authManager;
  final emailController = TextEditingController();
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
                      'Enter Your Email',
                      style: textTheme.titleMedium,
                    ),
                    Column(
                      children: [
                        TextField(
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          controller: emailController,
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
                            labelText: 'Email',
                            labelStyle: textTheme.labelSmall,
                          ),
                          style: textTheme.labelSmall,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (value) async {
                            await authManager.login(emailController.text);
                            if (mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginCodePage(
                                        authService: widget.authService,
                                        email: emailController.text)),
                              );
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Change Number ?',
                              style: textTheme.labelSmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        await authManager.login(emailController.text);
                        if (mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginCodePage(
                                    authService: widget.authService,
                                    email: emailController.text)),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(242, 121, 107, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 0,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Login',
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
                        GestureDetector(
                          onTap: () async {},
                          child: Text(
                            'Google',
                            style: textTheme.bodyMedium,
                          ),
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
                'Welcome back , ${emailController.text}',
                style: textTheme.displaySmall,
              ),
          ],
        )
      ],
    );
  }
}
