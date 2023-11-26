import 'package:flutter/material.dart';
import 'package:note_list_app/Screens/Login/login_screen.dart';
import 'package:note_list_app/Screens/SignUp/components/background.dart';
import 'package:note_list_app/components/already_have_an_account.dart';
import 'package:note_list_app/components/rounded_button.dart';
import 'package:note_list_app/components/rounded_confirm_password_field.dart';
import 'package:note_list_app/components/rounded_input_field.dart';
import 'package:note_list_app/components/rounded_password_fielld.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  final Widget child;

  const Body({Key? key, required this.child});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
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
              text: "SIGN UP",
              press: () {},
            ),
            AlreadyHaveAccountCheck(
              login: false,
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
      ),
    );
  }
}
