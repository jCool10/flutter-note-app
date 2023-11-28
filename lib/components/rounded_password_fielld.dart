import 'package:flutter/material.dart';
import 'package:note_list_app/components/text_field_container.dart';
import 'package:note_list_app/contants.dart';

class RoundedPasswordField extends StatelessWidget {
  final TextEditingController controller;
  const RoundedPasswordField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: true,
      controller: controller,
      decoration: const InputDecoration(
          hintText: "Your Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none),
    ));
  }
}
