import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_list_app/Screens/Login/components/background.dart';
import 'package:note_list_app/Screens/SignUp/signup_screen.dart';
import 'package:note_list_app/components/resset_account.dart';
import 'package:note_list_app/components/rounded_button.dart';
import 'package:note_list_app/components/rounded_input_field.dart';
import 'package:note_list_app/components/rounded_password_fielld.dart';

import '../../../components/already_have_an_account.dart';
import '../../../services/firebaseService.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required Column child,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _loginKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      key: _loginKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
          ),
          RoundedInputField(
              controller: _emailController,
              hintText: "Your Email",
              icon: Icons.email,
              obscureText: false),
          RoundedPasswordField(
            controller: _passwordController,
          ),
          RoundedButton(
            text: "LOGIN",
            press: () async {
              if (_loginKey.currentState!.validate()) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });

                FocusScope.of(context).unfocus();
                try {
                  await FirebaseService().signInWithEmailAndPassword(
                      _emailController.text.trim(),
                      _passwordController.text.trim());
                  Navigator.popUntil(context, (route) => route.isFirst);
                } on FirebaseAuthException catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message!),
                    ),
                  );
                }
              }
            },
          ),
          AlreadyHaveAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const SignupScreen();
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }
}
