import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/SignUp/components/background.dart';
import 'package:flutter_auth/components/already_have_an_account.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_confirm_password_field.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_fielld.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            "SIGN UP",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
          ),
          RoundedInputField(
            hintText: "Your name",
            icon: Icons.person,
            onChanged: (value) {},
          ),
          RoundedInputField(
            hintText: "Your email ",
            icon: Icons.email,
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          RoundedConfirmPasswordField(
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "SIGN Up",
            press: () {},
          ),
          AlreadyHaveAccountCheck(
            login: false,
            press: () {},
          )
        ],
      ),
    );
  }
}
