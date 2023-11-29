import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_list_app/Layout/CreateNote.dart';
import 'package:note_list_app/Layout/ViewNote.dart';
import 'package:note_list_app/Models/note.dart';
import 'package:note_list_app/components/note_drawer.dart';
import 'package:searchfield/searchfield.dart';

import '../Models/note.dart';
import '../services/firebaseService.dart';

class ViewCard extends StatefulWidget {
  const ViewCard({
    super.key,
  });

  @override
  State<ViewCard> createState() => _ViewCard();
}

class _ViewCard extends State<ViewCard> {
  List<Note> items = [];
  // late List<Map<String, String>> items;
  late List<String> search;
  late List<String> images;

  late Brightness currentBrightness;

  late bool isGridView;

  late final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    var notesPinned = items.where((item) => item.pinned == true).toList();
    var notes = items.where((item) => item.pinned == false).toList();

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
      data: currentBrightness == Brightness.light ? lightTheme : darkTheme,
      child: Scaffold(
        backgroundColor: (currentBrightness == Brightness.light)
            ? Colors.blue[100]
            : Colors.grey[500],
        appBar: AppBar(
          title: const Text(
            "View Card",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green[900],
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // show dialog
                        _showSearchDialog(context);
                      },
                      icon: const Icon(Icons.search)),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isGridView = !isGridView;
                      });
                    },
                    icon: Icon(isGridView ? Icons.view_list : Icons.grid_on),
                  ),
                  PopupMenuButton<String>(
                    onSelected: _handleMenuItemClick,
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: "Logout",
                          child: const Text("Logout"),
                          onTap: () async {
                            await FirebaseService().signOut();
                            Navigator.pushReplacementNamed(context, '/');
                          },
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              // move on create Note layout
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CreateNote()),
              );
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('Create note'),
          backgroundColor: Colors.grey,
        ),
        drawer: const DrawerWidget(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  color: (currentBrightness == Brightness.light)
                      ? Colors.yellowAccent[100]
                      : Colors.grey[500],
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'PINNED NOTE',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (!isGridView)
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: notesPinned.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // if(isPinned)
                                  ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notesPinned[index].title ?? "",
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'IndieFlower',
                                          ),
                                        ),
                                        Container(
                                          height: 2,
                                          color: (currentBrightness ==
                                                  Brightness.light)
                                              ? Colors.grey[500]
                                              : Colors.white,
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                        "Date: ${notesPinned[index].dateCreated ?? ""}"),
                                    trailing: const Text('Work'),
                                    onTap: () {
                                      // Handle item tap
                                      // print("Tapped on ${notesPinned[index]["title"]}");
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewNote(note: notes[index])),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      else
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: notesPinned.map((note) {
                            return Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // if(isPinned)
                                  ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.title ?? "",
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'IndieFlower',
                                          ),
                                        ),
                                        Container(
                                          height: 2,
                                          color: (currentBrightness ==
                                                  Brightness.light)
                                              ? Colors.grey[500]
                                              : Colors.white,
                                        ),
                                      ],
                                    ),
                                    subtitle:
                                        Text("Date: ${note.dateCreated ?? ""}"),
                                    trailing: const Text('Work'),
                                    onTap: () {
                                      // Handle item tap
                                      // print("Tapped on ${notesPinned[index]["title"]}");
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewNote(note: note)),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  color: (currentBrightness == Brightness.light)
                      ? Colors.yellowAccent[100]
                      : Colors.grey[500],
                  child: Column(
                    children: [
                      const Text(
                        'NOTE',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (!isGridView)
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notes[index].title ?? "",
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'IndieFlower',
                                          ),
                                        ),
                                        Container(
                                          height:
                                              2, // Set the height of the divider line
                                          color: (currentBrightness ==
                                                  Brightness.light)
                                              ? Colors.grey[500]
                                              : Colors.white,
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                        "Date: ${notes[index].dateCreated ?? ""}"),
                                    trailing: const Text('School'),
                                    onTap: () {
                                      // Handle item tap
                                      print("Tapped on ${notes[index].title}");
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewNote(note: notes[index])),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      else
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: notes.map((note) {
                            return Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // if(!isPinned)
                                  ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.title ?? "",
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'IndieFlower',
                                          ),
                                        ),
                                        Container(
                                          height:
                                              2, // Set the height of the divider line
                                          color: (currentBrightness ==
                                                  Brightness.light)
                                              ? Colors.grey[500]
                                              : Colors.white,
                                        ),
                                      ],
                                    ),
                                    subtitle:
                                        Text("Date: ${note.dateCreated ?? ""}"),
                                    trailing: const Text('School'),
                                    onTap: () {
                                      // Handle item tap
                                      print("Tapped on ${note.title}");
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewNote(note: note)),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      const SizedBox(
                        height: 20,
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

  Future<void> getNote() async {
    var response = await FirebaseService().getNotes();
    setState(() {
      items = response;
      search = items.map((item) => item.title ?? '').toList();
    });
  }

  // Future<void> getNote() async {
  //   var response = await FirebaseService().getNotes().then((value) {
  //     print(value);
  //     setState(() {
  //       items = value;
  //     });
  //   });
  //   print('items $items');
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   currentBrightness = Brightness.light;
  //   // items = [
  //   //   {"title": "Meeting", "date": "2023-11-27", "pin": "false"},
  //   //   {"title": "Appointment", "date": "2023-11-28", "pin": "false"},
  //   //   {"title": "Event", "date": "2023-11-29", "pin": "true"},
  //   //   {"title": "Deadline", "date": "2023-11-30", "pin": "false"},
  //   //   {"title": "Project Kick-off", "date": "2023-12-01", "pin": "true"},
  //   // ];
  //   items = [];
  //   // items = aw getNote() as List<Map<String, String>>;
  //   getNote();

  //   search = items.map((item) => item.title ?? '').toList();

  //   images = ['avarta.jpeg'];
  //   isGridView = true;
  // }

  @override
  void initState() {
    super.initState();
    getNote();
    currentBrightness = Brightness.light;
    // items = [];
    search = [];
    isGridView = true;
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

  void _showSearchDialog(BuildContext context) {
    // https://pub.dev/packages/searchfield
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search card'),
          content: Column(
            children: [
              SearchField(
                onSearchTextChanged: (query) {
                  final filter = search
                      .where((element) =>
                          element.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                  return filter
                      .map((e) => SearchFieldListItem<String>(
                            e,
                            child: Text(e,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.green)),
                          ))
                      .toList();
                },
                key: const Key('searchfield'),
                hint: 'Search by note title',
                itemHeight: 20,
                searchInputDecoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.red)),
                suggestionsDecoration: SuggestionDecoration(
                    padding: const EdgeInsets.all(4),
                    border: Border.all(color: Colors.red),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                suggestions: search
                    .map((e) => SearchFieldListItem<String>(
                          e,
                          child: Text(e,
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.green)),
                        ))
                    .toList(),
                onSuggestionTap: (SearchFieldListItem<String> x) {},
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  // move to view note layout
                  // title has from SearchField
                },
                child: const Text('Ok'))
          ],
        );
      },
    );
  }
}
