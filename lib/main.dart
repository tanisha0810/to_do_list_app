import 'package:flutter/material.dart';
import 'package:to_do_list/homePage.dart';

void main() {
  runApp(ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
