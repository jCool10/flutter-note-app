import 'package:flutter/material.dart';
import 'package:note_list_app/components/text_field_container.dart';
import 'package:note_list_app/contants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  const RoundedInputField({
    super.key,
    required this.hintText,
    this.icon = Icons.person,
    this.controller,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textInputAction: TextInputAction.next,
      obscureText: obscureText,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(icon),
        ),
        filled: true,
        fillColor: kPrimaryLightColor,
        iconColor: kPrimaryColor,
        prefixIconColor: kPrimaryColor,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
