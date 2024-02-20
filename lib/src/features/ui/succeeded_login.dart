import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_aveds/generated/l10n.dart';
import 'package:for_aveds/src/features/bll/auth_manager.dart';
import 'package:for_aveds/src/theme/text_theme.dart';

class SucceededLogin extends StatefulWidget {
  const SucceededLogin({
    required this.email,
    required this.jwt,
    super.key,
  });

  final String email;
  final String jwt;

  @override
  SucceededLoginState createState() => SucceededLoginState();
}

class SucceededLoginState extends State<SucceededLogin> {
  late final AuthManager authManager;
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBar(),
        backgroundColor: const Color.fromRGBO(229, 229, 229, 0.3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
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
                  'assets/images/png/Succeeded.png',
                  height: 250,
                  width: 370,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).successfulAuth,
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
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
              S.of(context).login,
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
            if (widget.jwt.isNotEmpty)
              Flexible(
                child: Text(
                  overflow: TextOverflow.clip,
                  '${S.of(context).walcomeBack} ${widget.email}',
                  style: textTheme.displaySmall,
                ),
              ),
          ],
        )
      ],
    );
  }
}
