import 'package:flutter/material.dart';
import 'package:note_list_app/Screens/Login/components/body.dart';
import 'package:note_list_app/Screens/Login/components/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginForm(),
    );
  }
}
