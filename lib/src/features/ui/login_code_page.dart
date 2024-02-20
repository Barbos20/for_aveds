import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_aveds/generated/l10n.dart';
import 'package:for_aveds/src/features/bll/auth_service.dart';
import 'package:for_aveds/src/features/ui/succeeded_login.dart';
import 'package:for_aveds/src/theme/text_theme.dart';

class LoginCodePage extends StatefulWidget {
  final String email;

  const LoginCodePage({
    required this.email,
    super.key,
  });

  @override
  LoginCodePageState createState() => LoginCodePageState();
}

class LoginCodePageState extends State<LoginCodePage> {
  final authManager = AuthService();
  final codeController = TextEditingController();
  bool _isLoading = false;

  void sendCode() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var result =
          await authManager.confirmCode(widget.email, codeController.text);
      String jwtToken = result['jwt'] ?? '';
      if (authManager.errorMessage == null) {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SucceededLogin(
                email: widget.email,
                jwt: jwtToken,
              ),
            ),
          );
        }
      } else {
        _showErrorDialog();
      }
    } catch (e) {
      _showErrorDialog();
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
                          S.of(context).enterCode,
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: S.of(context).code,
                                labelStyle: textTheme.labelSmall,
                              ),
                              style: textTheme.labelSmall,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (value) async {
                                sendCode();
                              },
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            sendCode();
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
                                  S.of(context).sendCode,
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ),
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
    return Row(
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
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(S.of(context).error),
          content: Text(S.of(context).errorModalTitle),
          actions: <Widget>[
            GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
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
                    horizontal: 20,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      S.of(context).ok,
                      style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
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
