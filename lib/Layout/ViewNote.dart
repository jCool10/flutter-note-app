import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  const ViewNote({super.key});

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  late Brightness _currentBrightness;
  final bool _isDarkModeEnabled = false;
  late List<String> images;
  
  late String titleTxt;
  late TextStyle titleStyle;
  late String tag;
  late String notesTxt;
  late TextStyle notesStyle;
   @override
  void initState() {
    super.initState();
    _currentBrightness = Brightness.light;

    images = ['avarta.jpeg'];

    // from data
    titleTxt = 'Learn Something';
    titleStyle = const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Colors.black);
    tag = 'Work';
    notesTxt = 'Go Go Go\n Hala Hala Hala\n From Hue';
    notesStyle = const TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
     //theme
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
    return Theme(data: _currentBrightness == Brightness.light ? lightTheme : darkTheme,
      child: Scaffold(
        backgroundColor: (_currentBrightness == Brightness.light) ? Colors.blue[100]: Colors.grey[500],
        appBar: AppBar(
          title: const Text(
            "Note Detail",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green[900],
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                        // -> move on create note with Title, tag and notes data
                    },
                  ),
                  const SizedBox(width: 5,),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                        // -> move on view note layout without save data
                    },
                  ),
                  const SizedBox(width: 5,),
                  IconButton(
                    icon: Transform.rotate(
                      angle: 45 * (3.141592653589793 / 180), // Convert degrees to radians
                      child: const Icon(Icons.push_pin),
                    ),
                    onPressed: () {
                      //  make pin == true
                    },
                  ),
                  const SizedBox(width: 5,),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      //  -> show dialog share
                    },
                  ),
                  const SizedBox(width: 5,),
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
            ),
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
                        backgroundImage: AssetImage('assets/${images[0]}'),
                        radius:  40.0,
                      ),
                      const Divider(height: 10,
                      color: Colors.black,),
                      Text("Anna Mie",
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 15.0,
                        color: (_currentBrightness == Brightness.light) ? Colors.black: Colors.white),
                      ),
                      Text("abc@gmail.com",
                      style: TextStyle(
                        // fontFamily: 'Pacifico',
                        fontSize: 15.0,
                        color: (_currentBrightness == Brightness.light) ? Colors.black: Colors.white
                      ),),
                      Text("Status: online",
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    color: (_currentBrightness == Brightness.light) ? Colors.yellowAccent[100]: Colors.blueGrey[500],
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        child: Text(
                          titleTxt,
                          style: titleStyle,
                        ),),
                    ),),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Card(
                      elevation: 10,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      color: (_currentBrightness == Brightness.light) ? Colors.red[100]: Colors.green[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0), // Đặt độ cong là 0.0 để có góc vuông
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.tag),
                          Text(
                              tag,
                              style: const TextStyle(
                                fontSize: 10.0,
                              ),
                            )
                        ],
                      ),),
                  ),
                  const Divider(height: 30,
                    color: Colors.grey,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      color: (_currentBrightness == Brightness.light) ? Colors.yellowAccent[100]: Colors.blueGrey[500],
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            child: Text(
                              'Notes:\n $notesTxt',
                              style: notesStyle,
                            ),),
                        ],
                      ),),
                  ),
                ],
              )
          ),
        ),
      ));
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