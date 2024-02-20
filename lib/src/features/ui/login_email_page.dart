import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_aveds/generated/l10n.dart';
import 'package:for_aveds/src/features/bll/auth_service.dart';
import 'package:for_aveds/src/features/ui/login_code_page.dart';
import 'package:for_aveds/src/theme/text_theme.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({super.key});

  @override
  LoginEmailPageState createState() => LoginEmailPageState();
}

class LoginEmailPageState extends State<LoginEmailPage> {
  final authManager = AuthService();
  final emailController = TextEditingController();
  bool _isError = false;
  bool _isLoading = false;

  void sendEmail() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await authManager.login(emailController.text);
      authManager.errorMessage;
      if (authManager.errorMessage == null) {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginCodePage(
                email: emailController.text,
              ),
            ),
          );
        }
      } else {
        _isError = true;
      }
    } catch (e) {
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
        authManager.errorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _appBar(),
        backgroundColor: _isLoading
            ? Colors.black.withOpacity(0.5)
            : const Color.fromRGBO(229, 229, 229, 0.3),
      ),
      body: Stack(
        children: [
          Container(
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
                          S.of(context).email,
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
                                border: _isError
                                    ? null
                                    : const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                focusedBorder: _isError
                                    ? const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      )
                                    : null,
                                enabledBorder: _isError
                                    ? const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      )
                                    : null,
                                fillColor: Colors.white,
                                filled: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: S.of(context).labelEmail,
                                labelStyle: textTheme.labelSmall,
                              ),
                              style: textTheme.labelSmall,
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                setState(() {
                                  _isError = false;
                                });
                              },
                              onSubmitted: (value) {
                                sendEmail();
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 20),
                              child: _isError
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          S.of(context).validEmail,
                                          style: textTheme.labelSmall?.copyWith(
                                            color: Colors.red,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        Text(
                                          S.of(context).changeNumber,
                                          style: textTheme.labelSmall,
                                        ),
                                      ],
                                    )
                                  : Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        S.of(context).changeNumber,
                                        style: textTheme.labelSmall,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            sendEmail();
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
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    S.of(context).login,
                                    style: textTheme.bodyMedium?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
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
                              S.of(context).loginWith,
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
                              child: Text(
                                S.of(context).google,
                                style: textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).dontAcc,
                              style: textTheme.labelMedium,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              S.of(context).signUp,
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
          _isLoading ? loadingOverlay() : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _appBar() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              S.of(context).login,
              style: textTheme.displayMedium,
            ),
            const SizedBox(
              width: 5,
            ),
            SvgPicture.asset('assets/images/svg/User.svg'),
          ],
        ),
      ],
    );
  }
}

Widget loadingOverlay() {
  return Stack(
    children: [
      ModalBarrier(dismissible: false, color: Colors.black.withOpacity(0.5)),
      const Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Color.fromRGBO(242, 121, 107, 1)),
        ),
      ),
    ],
  );
}
