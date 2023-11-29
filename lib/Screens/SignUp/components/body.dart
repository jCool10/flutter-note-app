import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_list_app/Screens/Login/components/body.dart';
import 'package:note_list_app/Screens/Login/login_screen.dart';
import 'package:note_list_app/Screens/SignUp/components/background.dart';
import 'package:note_list_app/components/already_have_an_account.dart';
import 'package:note_list_app/components/rounded_button.dart';
import 'package:note_list_app/components/rounded_confirm_password_field.dart';
import 'package:note_list_app/components/rounded_input_field.dart';
import 'package:note_list_app/components/rounded_password_fielld.dart';

import '../../../contants.dart';
import '../../../services/firebaseService.dart';

class Body extends StatefulWidget {
  // const Body({super.key, Key? key, required this.child});
  const Body({
    super.key,
    required Column child,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _signUpFormKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
            ),
            Form(
                child: Column(
              children: [
                RoundedInputField(
                  hintText: "Your name",
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: defaultPadding),
                RoundedInputField(
                  hintText: "Your email",
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  icon: Icons.mail,
                ),
                const SizedBox(height: defaultPadding),
                RoundedInputField(
                    hintText: "Your Password",
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    icon: Icons.lock,
                    obscureText: true),
                const SizedBox(height: defaultPadding),
                RoundedInputField(
                    hintText: "Your confirm Password",
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your confirm password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    icon: Icons.lock,
                    obscureText: true),
              ],
            )),
            RoundedButton(
              text: "SIGN UP",
              press: () async {
                if (_signUpFormKey.currentState!.validate()) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  print('_emailController.text ${_emailController.text}');
                  FocusScope.of(context).unfocus();

                  //Sign up user
                  String? errorMessage = await FirebaseService().signUpUser(
                    email: _emailController.text,
                    password: _passwordController.text,
                    name: _nameController.text,
                  );

                  if (errorMessage == null) {
                    //close circular progress indicator and navigate to next screen
                    Navigator.pop(context);
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const EmailScreen()),
                    // );
                  } else {
                    //close circular progress indicator and show error message
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                      ),
                    );
                  }
                }
              },
            ),
            AlreadyHaveAccountCheck(
              login: false,
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
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }
}
