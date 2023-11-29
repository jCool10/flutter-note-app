import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_list_app/Models/AccountUser.dart';

import '../services/firebaseService.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late Brightness _currentBrightness;
  final bool _isDarkModeEnabled = false;

  late AccountUser account;

  late List<String> tags;

  late final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
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

    return Theme(
      data: _currentBrightness == Brightness.light ? lightTheme : darkTheme,
      child: Scaffold(
        backgroundColor: (_currentBrightness == Brightness.light)
            ? Colors.blue[100]
            : Colors.grey[500],
        appBar: AppBar(
          title: const Text(
            "Setting",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green[900],
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  PopupMenuButton<String>(
                    onSelected: _handleMenuItemClick,
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem<String>(
                          value: "Logout",
                          child: Text("Logout"),
                        ),
                        const PopupMenuItem<String>(
                          value: "More info",
                          child: Text("More info"),
                        ),
                        const PopupMenuItem<String>(
                          value: "Help",
                          child: Text("Help"),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        drawer: Drawer(
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
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/${account.image}'),
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
                                        fontFamily: 'Pacifico',
                                        fontSize: 15.0,
                                        color: (_currentBrightness ==
                                                Brightness.light)
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                  Text(
                                    'Status: ${auth.currentUser!.emailVerified ? 'online' : 'offline'}',
                                    style: TextStyle(
                                        fontFamily: 'Pacifico',
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Đặt độ cong là 0.0 để có góc vuông
                  ),
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  color: (_currentBrightness == Brightness.light)
                      ? Colors.yellowAccent[100]
                      : Colors.grey[500],
                  child: Column(
                    children: [
                      const Center(
                        child: Text('Tags',
                            style: TextStyle(
                              fontFamily: 'VinaSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: (_currentBrightness == Brightness.light)
                            ? Colors.white
                            : Colors.grey[500],
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Show Text input and add tag
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      0.0), // Đặt góc vuông ở đây
                                ),
                                child: const Row(children: [
                                  Icon(Icons.add),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('Add Tag'),
                                ]),
                              ),
                            ),
                            Wrap(
                              spacing: 0.0,
                              runSpacing: 0.0,
                              children: tags.map((tag) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        0.0), // Đặt góc vuông ở đây
                                  ),
                                  child: Row(children: [
                                    const Icon(Icons.tag),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(tag),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: const Icon(Icons.more_vert),
                                          onPressed: () {
                                            // show dialog delete, edit
                                          },
                                        ),
                                      ),
                                    )
                                  ]),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Đặt độ cong là 0.0 để có góc vuông
                  ),
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  color: (_currentBrightness == Brightness.light)
                      ? Colors.yellowAccent[100]
                      : Colors.grey[500],
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          'About',
                          style: TextStyle(
                            fontFamily: 'VinaSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: (_currentBrightness == Brightness.light)
                            ? Colors.white
                            : Colors.grey[500],
                        child: InkWell(
                          onTap: () {
                            // open browser
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  0.0), // Đặt góc vuông ở đây
                            ),
                            child: const Row(children: [
                              Icon(Icons.info),
                              SizedBox(
                                width: 20,
                              ),
                              Text('About us'),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> initState() async {
    super.initState();
    _currentBrightness = Brightness.light;
    //from data
    FirebaseService().getNotesStream();
    // account = AccountUser('avarta.jpeg', "Anna Mie", 'abc@gmail.com', true);
    tags = ['Spend', 'Work', 'School', 'Exercise', 'Bank'];
  }

  void _handleMenuItemClick(String menuItem) {
    // Handle menu item click based on the selected item
    print("Selected item: $menuItem");
    switch (menuItem) {
      case 'Logout':
        // Move to Signin layout
        break;
      case 'More info':
        // Open link
        break;
      case 'Help':
        // Open link
        break;
      default:
    }
  }
}
