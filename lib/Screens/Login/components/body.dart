import 'package:flutter/material.dart';
import 'package:note_list_app/Screens/Login/components/background.dart';
import 'package:note_list_app/Screens/SignUp/signup_screen.dart';
import 'package:note_list_app/components/resset_account.dart';
import 'package:note_list_app/components/rounded_button.dart';
import 'package:note_list_app/components/rounded_input_field.dart';
import 'package:note_list_app/components/rounded_password_fielld.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/already_have_an_account.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required Column child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
          ),
          RoundedInputField(
            hintText: "Your Email",
            icon: Icons.email,
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {},
          ),
          AlreadyHaveAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SignupScreen();
                }),
              );
            },
          ),
          const SizedBox(
            height: 5,
          ),
          ResetAccount(
            press: () {

            },
          )
        ],
      ),
    );
  }
}
