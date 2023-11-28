import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Forgot/components/background.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Mail/checkmail_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/login_again.dart';

class Body extends StatelessWidget {
  final Widget child;

  const Body({Key? key, required this.child});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Forget Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          SvgPicture.asset(
            "assets/icons/forget.svg",
            height: size.height * 0.5,
          ),
          Text(
            "A password reset link will be sent to your email\nto reset your password. If you don't get an email\nwithin a few minutes, please re-try.",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          RoundedInputField(
            hintText: "Your Email",
            icon: Icons.email,
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "Reset Password",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CheckMailScreen();
              }));
            },
          ),
          LoginAgain(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }),
              );
            },
          )
        ],
      ),
    );
  }
}
