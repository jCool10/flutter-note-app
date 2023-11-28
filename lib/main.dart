import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_list_app/Layout/ViewCard.dart';
import 'package:note_list_app/Screens/Login/login_screen.dart';
import 'package:note_list_app/Screens/SignUp/signup_screen.dart';
import 'package:note_list_app/contants.dart';
import 'package:note_list_app/utils/auth.dart';
import 'package:note_list_app/utils/auth_guard.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   home: ViewCard()
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
      // Routing here
      initialRoute: '/',
      routes: {
        '/': (context) => const MyAuth(),
        '/login': (context) => FutureBuilder<bool>(
              future: AuthGuard.isAuthenticated(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!) {
                  return const ViewCard();
                } else {
                  return const LoginScreen();
                }
              },
            ),
        '/signup': (context) => FutureBuilder<bool>(
              future: AuthGuard.isAuthenticated(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!) {
                  return const ViewCard();
                } else {
                  return const SignupScreen();
                }
              },
            ),
      },
    );
  }
}
