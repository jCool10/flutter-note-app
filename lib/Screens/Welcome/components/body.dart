import 'package:flutter/material.dart';
import 'package:note_list_app/Screens/Login/login_screen.dart';
import 'package:note_list_app/Screens/SignUp/signup_screen.dart';
import 'package:note_list_app/Screens/Welcome/components/background.dart';
import 'package:note_list_app/components/rounded_button.dart';
import 'package:note_list_app/contants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.1,
            ),
            Text(
              "WELCOME BACK !",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/icons/chat.svg",
                height: size.height * 0.45,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ));
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor, // Màu nền nhạt hơn
              textColor: Colors.white, // Màu chữ tím
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignupScreen();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
