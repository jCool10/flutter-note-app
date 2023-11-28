import 'package:flutter/material.dart';
import 'package:note_list_app/Screens/SignUp/components/body.dart';
import 'package:note_list_app/Screens/SignUp/components/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignUpForm(),
    );
  }
}
