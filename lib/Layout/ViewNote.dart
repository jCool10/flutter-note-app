import 'package:flutter/material.dart';
import 'package:note_list_app/Layout/ViewCard.dart';
import 'package:note_list_app/Models/note.dart';
import 'package:note_list_app/components/note_drawer.dart';
import 'package:note_list_app/services/firebaseService.dart';

class ViewNote extends StatefulWidget {
  final Note note;
  const ViewNote({super.key, required this.note});

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  late Brightness _currentBrightness;
  late List<String> images;

  late String titleTxt;
  late TextStyle titleStyle;
  late List<dynamic> tag;
  late String notesTxt;
  late TextStyle notesStyle;

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
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        String result = await showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Delete permanently?'),
                            content: const Text(
                                'This note will be deleted permanently and cannot be recovered.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, 'cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, 'delete'),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                        if (result == 'delete') {
                          await FirebaseService().deleteNote(note: widget.note);
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
                      icon: Transform.rotate(
                        angle: 45 *
                            (3.141592653589793 /
                                180), // Convert degrees to radians
                        child: const Icon(Icons.push_pin),
                      ),
                      onPressed: () async {
                        //  make pin == true
                        final note = Note(
                          id: widget.note.id,
                          title: widget.note.title,
                          trashed: widget.note.trashed,
                          pinned: !widget.note.pinned,
                          content: widget.note.content,
                          password: widget.note.password,
                          tags: widget.note.tags,
                          reminder: widget.note.reminder,
                          dateCreated: widget.note.dateCreated,
                          dateModified: DateTime.now(),
                        );
                        await FirebaseService()
                            .updateNote(oldNote: widget.note, newNote: note);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewCard()),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        //  -> show dialog share
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
          drawer: const DrawerWidget(),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 10,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      color: (_currentBrightness == Brightness.light)
                          ? Colors.yellowAccent[100]
                          : Colors.blueGrey[500],
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          child: Text(
                            titleTxt,
                            style: titleStyle,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Card(
                        elevation: 10,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        color: (_currentBrightness == Brightness.light)
                            ? Colors.red[100]
                            : Colors.green[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0.0), // Đặt độ cong là 0.0 để có góc vuông
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.tag),
                            // Text(
                            //   '$tag',
                            //   style: const TextStyle(
                            //     fontSize: 10.0,
                            //   ),
                            // )
                            Wrap(
                              children: tag.map((t) {
                                print(t);
                                return Text(
                                  t,
                                  style: notesStyle,
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 30,
                      color: Colors.grey,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        color: (_currentBrightness == Brightness.light)
                            ? Colors.yellowAccent[100]
                            : Colors.blueGrey[500],
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              child: Text(
                                'Notes:\n $notesTxt',
                                style: notesStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    _currentBrightness = Brightness.light;

    images = ['avarta.jpeg'];

    // from data
    titleTxt = widget.note.title;
    titleStyle = const TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: Colors.black);

    print(widget.note.tags);
    tag = widget.note.tags;
    notesTxt = widget.note.content;
    notesStyle = const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        color: Colors.black);
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
