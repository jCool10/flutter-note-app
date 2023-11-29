import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firebaseService.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidget();
}

class _DrawerWidget extends State<DrawerWidget> {
  late Brightness _currentBrightness = Brightness.light;
  final bool _isDarkModeEnabled = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.blue[100],
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(color: Colors.black, opacity: 1),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.orange,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.grey,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.orange,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: const ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 1),
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: _currentBrightness == Brightness.light ? lightTheme : darkTheme,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 200,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: (_currentBrightness == Brightness.light)
                        ? Colors.white
                        : Colors.grey[900],
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('../../assets/avarta.jpeg'),
                        radius: 40.0,
                      ),
                      StreamBuilder(
                          stream: FirebaseService().getNotesStream(),
                          builder: (context,
                              AsyncSnapshot<
                                      DocumentSnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.hasData) {
                              final data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              final profile =
                                  data['user_profile'] as Map<String, dynamic>;
                              return Column(
                                children: [
                                  Text(
                                    profile['name'],
                                    style: TextStyle(
                                        fontFamily: 'Pacifico',
                                        fontSize: 15.0,
                                        color: (_currentBrightness ==
                                                Brightness.light)
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                  const Divider(
                                    height: 10,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    profile['email'],
                                    style: TextStyle(
                                        // fontFamily: 'Pacifico',
                                        fontSize: 15.0,
                                        color: (_currentBrightness ==
                                                Brightness.light)
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ],
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          })
                    ],
                  ),
                ),
              ),
              ListTile(
                title: const Row(children: [
                  Icon(Icons.card_membership),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Card')
                ]),
                onTap: () {
                  // Handle item 1 tap
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: const Row(children: [
                  Icon(Icons.delete),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Trash')
                ]),
                onTap: () {
                  // Handle item 1 tap
                  Navigator.pop(context); // Close the drawer
                },
              ),
              Container(
                height: 1,
                color: Colors.black,
              ),
              ListTile(
                title: const Row(children: [
                  Icon(Icons.account_circle),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Account')
                ]),
                onTap: () {
                  // Handle item 1 tap

                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: Row(children: [
                  const Icon(Icons.dark_mode),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                      'Dark Mode: ${_currentBrightness == Brightness.dark ? 'On' : 'Off'}'),
                  const SizedBox(
                    width: 30,
                  ),
                  Switch(
                    value: _isDarkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _currentBrightness =
                            (_currentBrightness == Brightness.light)
                                ? Brightness.dark
                                : Brightness.light;
                      });
                    },
                  ),
                ]),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              Container(
                height: 1,
                color: Colors.black,
              ),
              ListTile(
                title: const Row(children: [
                  Icon(Icons.settings),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Settting')
                ]),
                onTap: () {
                  // Handle item 3 tap
                  Navigator.pop(context); // Close the drawer
                },
              ),
            ],
          ),
        ));
  }
}
