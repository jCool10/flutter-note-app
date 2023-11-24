import 'package:flutter/material.dart';
import 'package:note_list_app/Models/AccountUser.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _Account();
}
class _Account extends State<Account> {

  late Brightness _currentBrightness;
  final bool _isDarkModeEnabled = false;

  late AccountUser account;

  @override
  void initState() {
    super.initState();
    _currentBrightness = Brightness.light;
    account = AccountUser('avarta.jpeg', "Anna Mie", 'abc@gmail.com', true);
  }

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.blue[100],
      colorScheme: const ColorScheme.light(),
      iconTheme: const IconThemeData(color: Colors.black, opacity: 1),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.orange,
        textTheme: ButtonTextTheme.primary,),
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
        backgroundColor: (_currentBrightness == Brightness.light) ? Colors.blue[100]: Colors.grey[500],
        appBar: AppBar(
          title: const Text(
            "Account",
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
                    color: (_currentBrightness == Brightness.light) ? Colors.white: Colors.grey[900],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/${account.image}'),
                        radius:  40.0,
                      ),
                      const Divider(height: 10,
                      color: Colors.black,),
                      Text(account.name,
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 15.0,
                        color: (_currentBrightness == Brightness.light) ? Colors.black: Colors.white),
                      ),
                      Text(account.mail,
                      style: TextStyle(
                        // fontFamily: 'Pacifico',
                        fontSize: 15.0,
                        color: (_currentBrightness == Brightness.light) ? Colors.black: Colors.white
                      ),),
                      Text('Status: ${(account.status) ? 'online':'offline'}' ,
                      style: TextStyle(
                        // fontFamily: 'Pacifico',
                        fontSize: 15.0,
                        color: (_currentBrightness == Brightness.light) ? Colors.black: Colors.white
                      ),),
                    ],
                  ), 
                ),
              ),
              ListTile(
                title: const Row(children: [
                  Icon(Icons.card_membership),
                   SizedBox(width: 30,),
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
                   SizedBox(width: 30,),
                  Text('Trash')
                ]),
                onTap: () {
                  // Handle item 1 tap
                  Navigator.pop(context); // Close the drawer
                },
              ),
              Container(height: 1,
              color: Colors.black,),
              ListTile(
                title: const Row(children: [
                  Icon(Icons.account_circle),
                   SizedBox(width: 30,),
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
                  const SizedBox(width: 30,),
                  Text('Dark Mode: ${_currentBrightness == Brightness.dark ? 'On' : 'Off'}'),
                  const SizedBox(width: 30,),
                  Switch(
                    value: _isDarkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                          _currentBrightness = (_currentBrightness == Brightness.light) ? Brightness.dark : Brightness.light;
                      });
                    },
                  ),
                ]),
                onTap: () {
                 
                  Navigator.pop(context); // Close the drawer
                },
              ),
              Container(height: 1,
              color: Colors.black,),
              ListTile(
                title: const Row(children: [
                  Icon(Icons.settings),
                  SizedBox(width: 30,),
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
                        borderRadius: BorderRadius.circular(10.0), // Đặt độ cong là 0.0 để có góc vuông
                      ),
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                color: (_currentBrightness == Brightness.light) ? Colors.yellowAccent[100]: Colors.grey[500],
                child: Column(children: [
                    const Center(
                      child: Text('Account',
                      style: TextStyle(
                        fontFamily: 'VinaSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),)
                      ,
                    ),
                     Container(
                      margin: const EdgeInsets.fromLTRB(40, 10, 0, 20),
                      alignment: Alignment.center,
                       child: Row(
                         children: [
                           CircleAvatar(
                              backgroundImage: AssetImage('assets/${account.image}'),
                              radius:  40.0,
                            ),
                            const SizedBox(width: 20,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(account.name,
                                style: TextStyle(
                                  fontFamily: 'Pacifico',
                                  fontSize: 15.0,
                                  color: (_currentBrightness == Brightness.light) ? Colors.black: Colors.white),
                                ),
                                Text(account.mail,
                                style: TextStyle(
                                  // fontFamily: 'Pacifico',
                                  fontSize: 15.0,
                                  color: (_currentBrightness == Brightness.light) ? Colors.black: Colors.white
                                ),),
                                Text('Status: ${(account.status) ? 'online':'offline'}' ,
                                style: TextStyle(
                                  // fontFamily: 'Pacifico',
                                  fontSize: 15.0,
                                  color: (_currentBrightness == Brightness.light) ? Colors.black: Colors.white
                                ),),
                              ],
                            ),
                         ],
                       ),
                     ),
                ],)
              ),
              Divider(height: 40,
                color: (_currentBrightness == Brightness.light) ? Colors.grey[900]: Colors.white,),
              Column(children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0), // Đặt góc vuông ở đây
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      
                    });
                  },
                  child:const Row(children: [
                    Icon(Icons.image),
                    SizedBox(width: 20,),
                    Text('Change Avatar'),
                  ]),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0), // Đặt góc vuông ở đây
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      
                    });
                  },
                  child:const Row(children: [
                    Icon(Icons.password),
                    SizedBox(width: 20,),
                    Text('Change Password'),
                  ]),
                ),
                const SizedBox(height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0), // Đặt góc vuông ở đây
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        
                      });
                    },
                    child:const Row(children: [
                      Icon(Icons.mail),
                      SizedBox(width: 20,),
                      Text('Upgrade mail'),
                    ]),
                  ),
              ],),
            ],),
          ),
        ),
      ),
    );
  }
  void _handleMenuItemClick(String menuItem) {
    // Handle menu item click based on the selected item
    print("Selected item: $menuItem");
    switch(menuItem) {
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