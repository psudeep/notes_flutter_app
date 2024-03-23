import 'package:flutter/material.dart';
import 'package:notes_lelo/presentation/screens/login_screen.dart';
import 'package:notes_lelo/presentation/screens/note_list_screen.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomeScreen(),
        '/notes': (context) => NotesListScreen(),
        '/login': (context) => LoginScreen(),
      },
      //home: HomeScreen(),
    );
  }
}
