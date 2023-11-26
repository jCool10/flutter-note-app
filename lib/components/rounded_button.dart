import 'package:flutter/material.dart';
import 'package:note_list_app/contants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback? press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    this.text = '',
    this.press = _defaultPress,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  static void _defaultPress() {
    // Hành động mặc định khi press không được truyền vào
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: press,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Text(
                  text,
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          ),
        ));
  }
}
