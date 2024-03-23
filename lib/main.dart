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
        primarySwatch: MaterialColor(
          Colors.black.value,
          <int, Color>{
            50: Colors.black,
            100: Colors.black,
            200: Colors.black,
            300: Colors.black,
            400: Colors.black,
            500: Colors.black,
            600: Colors.black,
            700: Colors.black,
            800: Colors.black,
            900: Colors.black,
          },
        ),
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
