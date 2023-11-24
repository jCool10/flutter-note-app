import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  // Config Text
  double _fontSize = 16.0;
  FontWeight _fontWeight = FontWeight.normal;
  FontStyle _fontStyle = FontStyle.normal;
  Color _textColor = Colors.black;
  // Style config
  late TextStyle _titleStyle;
  late TextStyle _notesStyle;
  //tag
  late List<String> tags;
  late String selectedItem;
  //title
  late TextEditingController _titleInput;
  late FocusNode _focusNodeTitle;
  //Notes
  late TextEditingController _notesInput;
  late FocusNode _focusNodeNotes;
  //avarta
  late List<String> images;
  //theme
  late Brightness _currentBrightness;
  final bool _isDarkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _currentBrightness = Brightness.light;
    tags = ['Spend', 'Work', 'School', 'Exercise', 'Bank'];
    selectedItem = 'Spend';
    images = ['avarta.jpeg'];

    _titleStyle = const TextStyle(fontSize: 25.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Colors.black);
    _notesStyle = const TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Colors.black);

    _titleInput = TextEditingController();
    _focusNodeTitle = FocusNode();
    _notesInput = TextEditingController();
    _focusNodeNotes = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
     //theme
    final lightTheme = ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.blue[100],
      colorScheme: const ColorScheme.light(),
      iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.orange,
        textTheme: ButtonTextTheme.primary,),
    );
    final darkTheme = ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.grey,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.white,
        textTheme: ButtonTextTheme.primary,
      ),
      colorScheme: const ColorScheme.dark(),
      iconTheme: const IconThemeData(color: Colors.white, opacity: 0.8),
    );

    return Theme(data: _currentBrightness == Brightness.light ? lightTheme : darkTheme,
      child: Scaffold(
        backgroundColor: (_currentBrightness == Brightness.light) ? Colors.blue[100]: Colors.grey[500],
        appBar: AppBar(
          title: const Text(
            "Create Note",
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
                    icon: const Icon(Icons.access_alarm),
                    onPressed: () {
                        // -> show dialog clock
                        _showNotificationDialog(context);
                    },
                  ),
                  const SizedBox(width: 5,),
                  IconButton(
                    icon: const Icon(Icons.save, color: Colors.blue,),
                    onPressed: () {
                      if (_titleInput.text.isEmpty) {
                        _focusNodeTitle.requestFocus();
                        _vibrate();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Title is Empty"),
                        ));
                      } else if(_notesInput.text.isEmpty) {
                        _focusNodeNotes.requestFocus();
                        _vibrate();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Note is Empty"),
                        ));
                      } 
                      else {
                        // -> move on view note layout and save data
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Saved note"),
                        ));
                        _notesInput.text = '';
                        _titleInput.text = '';
                      }
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
          child: Padding(padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(children: [
                TextField(
                  controller: _titleInput,
                  focusNode: _focusNodeTitle,
                  style: _titleStyle,
                  onChanged: (value) {
                    setState(() {
                      _titleStyle = _titleStyle.copyWith(
                        fontSize: _fontSize,
                        fontWeight: _fontWeight,
                        fontStyle: _fontStyle,
                        color: _textColor,
                      );
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter your title',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.title),
                    hintStyle: TextStyle(
                      fontSize: 25.0
                    ),
                    
                  ),
                ),
                // Dropdown - tag
                const SizedBox(height: 20,),
               Row(
                children: [
                  const Icon(Icons.tag),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedItem,
                        items: tags.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            selectedItem = newValue;
                          }
                        },
                      ),
                    ),
                  ),
                ],),

                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Slider(
                      value: _fontSize,
                      min: 10.0,
                      max: 30.0,
                      onChanged: (value) {
                        setState(() {
                          _fontSize = value;
                        });
                    },),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _fontWeight =
                              _fontWeight == FontWeight.normal ? FontWeight.bold : FontWeight.normal;
                        });
                      },
                      child: const Icon(Icons.format_bold),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _fontStyle =
                              _fontStyle == FontStyle.normal ? FontStyle.italic : FontStyle.normal;
                        });
                      },
                      child: const Icon(Icons.format_italic),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectTextColor(context);
                        });
                      },
                      child: const Icon(Icons.color_lens),
                    ),

                ],),
                const SizedBox(height: 20,),
                Container(height: 2,
                color: (_currentBrightness == Brightness.light)? Colors.grey[500]:Colors.white),
                const SizedBox(height: 20,),
                TextField(
                  controller: _notesInput,
                  focusNode: _focusNodeNotes,
                  style: _notesStyle,
                  onChanged: (value) {
                    setState(() {
                      _notesStyle = _notesStyle.copyWith(
                        fontSize: _fontSize,
                        fontWeight: _fontWeight,
                        fontStyle: _fontStyle,
                        color: _textColor,
                      );
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    hintText: 'Enter your Notes',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.note),
                    hintStyle: TextStyle(
                      fontSize: 15.0
                    )
                  ),
                  maxLines: null, 
                  minLines: 5,  
                  keyboardType: TextInputType.multiline,
                ),
                
              ]),
          ),
        ),
      ));
  }

  void _vibrate() {
    HapticFeedback.vibrate();
  }
  _selectTextColor(BuildContext context) async {
    Color? selectedColor = await showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Text Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _textColor,
              onColorChanged: (Color color) {
                setState(() {
                  _textColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    if (selectedColor != null) {
      setState(() {
        _textColor = selectedColor;
      });
    }
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
  Future<void> _showNotificationDialog(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      // Set up local notifications
      // const AndroidInitializationSettings initializationSettingsAndroid =
      //     AndroidInitializationSettings('@mipmap/ic_launcher');
      // final InitializationSettings initializationSettings =
      //     InitializationSettings(android: initializationSettingsAndroid);
      // await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // Schedule the notification
      await _scheduleNotification(selectedTime);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Notification Scheduled'),
            content: Text('Notification set for ${selectedTime.format(context)}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _scheduleNotification(TimeOfDay time) async {
    final DateTime now = DateTime.now();
    DateTime scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      // If the selected time is in the past, schedule it for the next day
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }

    // final int notificationId = scheduledDate.millisecondsSinceEpoch ~/ 1000;

    // const AndroidNotificationDetails androidPlatformChannelSpecifics =
    //     AndroidNotificationDetails(
    //   'your_channel_id', // Change this channel ID
    //   'Scheduled Notification',
    //   'Scheduled notification description',
    //   importance: Importance.high,
    //   priority: Priority.high,
    // );
    // const NotificationDetails platformChannelSpecifics =
    //     NotificationDetails(android: androidPlatformChannelSpecifics);

    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //   notificationId,
    //   'Scheduled Notification',
    //   'This is your scheduled notification',
    //   scheduledDate,
    //   const NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       'your_channel_id', // Change this channel ID
    //       'Scheduled Notification',
    //       'Scheduled notification description',
    //       importance: Importance.high,
    //       priority: Priority.high,
    //     ),
    //   ),
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.absoluteTime,
    //   androidAllowWhileIdle: true,
    //   payload: 'Scheduled Notification Payload',
    // );
  }
}