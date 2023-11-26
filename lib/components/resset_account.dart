import 'package:flutter/material.dart';
import 'package:note_list_app/Screens/Verifaction/forgot.dart';
import 'package:note_list_app/contants.dart';

class ResetAccount extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const ResetAccount({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Forgot your password ?",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ForgotScreen();
              }),
            );
          },
          child: Text(
            " Reset Now",
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
