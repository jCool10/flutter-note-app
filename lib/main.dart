import 'package:flutter/material.dart';
import 'package:note_list_app/Layout/Account.dart';
import 'package:note_list_app/Layout/CreateNote.dart';
import 'package:note_list_app/Layout/Setting.dart';
import 'package:note_list_app/Layout/ViewCard.dart';
import 'package:note_list_app/Layout/ViewNote.dart';

void main() {
  
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
    return const MaterialApp(
      home: ViewCard()
    );
  }
}