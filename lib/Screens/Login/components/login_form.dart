import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_list_app/Layout/ViewCard.dart';
import 'package:note_list_app/Screens/Login/components/background.dart';
import 'package:note_list_app/Screens/SignUp/components/signup_form.dart';
import 'package:note_list_app/Screens/SignUp/signup_screen.dart';
import 'package:note_list_app/components/rounded_input_field.dart';

// import '/screens/Otp/email.dart';
import '../../../components/already_have_an_account.dart';
import '../../../components/already_have_an_account.dart';
import '../../../contants.dart';
import '../../../services/firebase_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _LoginFormKey = GlobalKey<FormState>();

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
              key: _LoginFormKey,
              child: Column(
                children: [
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
                  const SizedBox(height: defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: kPrimaryColor,
                      shape: const StadiumBorder(),
                      maximumSize: const Size(double.infinity, 56),
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    onPressed: () async {
                      if (_LoginFormKey.currentState!.validate()) {
                        //show circular progress indicator
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        //unfocus all text fields
                        FocusScope.of(context).unfocus();
                        //Sign up user
                        try {
                          await FirebaseService().signInWithEmailAndPassword(
                              _emailController.text.trim(),
                              _passwordController.text.trim());
                          // Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewCard()),
                          );
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
                    child: Text("Login".toUpperCase()),
                  ),
                  const SizedBox(height: defaultPadding),
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
            )
          ]),
    ));
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
