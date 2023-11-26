import 'package:flutter/material.dart';
import 'package:note_list_app/components/text_field_container.dart';
import 'package:note_list_app/contants.dart';

class RoundedConfirmPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedConfirmPasswordField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: true,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: "Your confirm password",
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
