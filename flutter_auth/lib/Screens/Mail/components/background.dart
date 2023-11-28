import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              child: Image.asset(
            "assets/images/signup_top.png",
            width: size.width * 0.35,
          )),
          Positioned(
              child: Image.asset(
            "assets/images/main_bottom.png",
            width: size.width * 0.35,
          )),
          child,
        ],
      ),
    );
  }
}
