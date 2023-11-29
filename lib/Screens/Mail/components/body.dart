import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/login_again.dart';
import '../../../components/rounded_button.dart';
import '../../Login/components/background.dart';
import '../../Login/login_screen.dart';

class Body extends StatelessWidget {
  final Widget child;

  const Body({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Check your mail",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          SvgPicture.asset(
            "assets/icons/emailsend.svg",
            height: size.height * 0.5,
          ),
          RoundedButton(
            text: "Open email app",
            press: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return CheckMailScreen();
              // }));
            },
          ),
          LoginAgain(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }),
              );
            },
          )
        ],
      ),
    );
  }
}
