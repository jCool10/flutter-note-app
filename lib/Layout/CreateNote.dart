import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note_list_app/Layout/ViewCard.dart';
import 'package:note_list_app/components/note_drawer.dart';
import 'package:note_list_app/services/firebaseService.dart';

String generateNumericUuid() {
  final random = Random();
  final maxIntValue = pow(10, 9).toInt(); // Generate integers up to 1 billion
  final numericUuid = random.nextInt(maxIntValue);
  return numericUuid.toString();
}

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final QuillController _controller = QuillController.basic();
  late TextEditingController _titleController;
  String uuid = generateNumericUuid();
  final String _pickedDate = '';
  final String _pickedTime = '';
  final FirebaseService _firebaseService = FirebaseService();

  List<String> tags = <String>[];
  List<String> selectedTags = <String>[];

  // Config Text
  final double _fontSize = 16.0;
  final FontWeight _fontWeight = FontWeight.normal;
  final FontStyle _fontStyle = FontStyle.normal;
  Color _textColor = Colors.black;
  // Style config
  late TextStyle _titleStyle;
  late TextStyle _notesStyle;
  //tag
  // late List<String> tags;
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
  Widget build(BuildContext context) {
    //theme
    final lightTheme = ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.blue[100],
      colorScheme: const ColorScheme.light(),
      iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.orange,
        textTheme: ButtonTextTheme.primary,
      ),
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

    return Theme(
        data: _currentBrightness == Brightness.light ? lightTheme : darkTheme,
        child: Scaffold(
          backgroundColor: (_currentBrightness == Brightness.light)
              ? Colors.blue[100]
              : Colors.grey[500],
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
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.save,
                        color: Colors.blue,
                      ),
                      onPressed: () async {
                        if (_titleInput.text.isEmpty) {
                          _focusNodeTitle.requestFocus();
                          _vibrate();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Title is Empty"),
                          ));
                        } else if (_notesInput.text.isEmpty) {
                          _focusNodeNotes.requestFocus();
                          _vibrate();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Note is Empty"),
                          ));
                        } else {
                          // -> move on view note layout and save data
                          await FirebaseService().addNote(
                            uuid: uuid,
                            title: _titleInput.text,
                            content: _notesInput.text,
                            selectedTags: [selectedItem],
                            reminder: _pickedDate == '' || _pickedTime == ''
                                ? ''
                                : '$_pickedDate $_pickedTime',
                          );

                          // Navigator.pop(context, true);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Saved note"),
                          ));
                          _notesInput.text = '';
                          _titleInput.text = '';
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewCard()),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // -> move on view note layout without save data
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: Transform.rotate(
                        angle: 45 *
                            (3.141592653589793 /
                                180), // Convert degrees to radians
                        child: const Icon(Icons.push_pin),
                      ),
                      onPressed: () {
                        //  make pin == true
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Quay lại màn hình trước đó khi nhấn nút
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewCard()),
                );
              },
            ),
          ),

          // drawer: const DrawerWidget(),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
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
                    hintStyle: TextStyle(fontSize: 25.0),
                  ),
                ),
                // Dropdown - tag
                const SizedBox(
                  height: 20,
                ),
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
                            // print(values);
                            if (newValue != null) {
                              // setState(() {
                              selectedItem = newValue;
                              // });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
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
                      hintStyle: TextStyle(fontSize: 15.0)),
                  maxLines: null,
                  minLines: 5,
                  keyboardType: TextInputType.multiline,
                ),
              ]),
            ),
          ),
        ));
  }

  @override
  void initState() {
    _currentBrightness = Brightness.light;

    _firebaseService.getTags().then((value) {
      print(value);
      // setState(() {
      //   tags = value;
      // });
    });

    tags = ['Spend', 'Work', 'School', 'Exercise', 'Bank'];
    selectedItem = 'Spend';
    images = ['avarta.jpeg'];
    _titleController = TextEditingController();

    _titleStyle = const TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        color: Colors.black);
    _notesStyle = const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        color: Colors.black);

    _titleInput = TextEditingController();
    _focusNodeTitle = FocusNode();
    _notesInput = TextEditingController();
    _focusNodeNotes = FocusNode();
    super.initState();
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
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
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

  Future<void> _showNotificationDialog(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      await _scheduleNotification(selectedTime);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Notification Scheduled'),
            content:
                Text('Notification set for ${selectedTime.format(context)}'),
            actions: <Widget>[
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
    }
  }

  void _vibrate() {
    HapticFeedback.vibrate();
  }
}
