import 'package:flutter/material.dart';

class LoginAgain extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const LoginAgain({
    super.key,
    this.login = true,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: const Text(
            "Login again ?",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
