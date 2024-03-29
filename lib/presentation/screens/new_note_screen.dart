// lib/screens/new_note_screen.dart

import 'package:flutter/material.dart';
import 'package:notes_lelo/data/models/note.dart';
import '../../data/note_database.dart';
import '../../common/toast.dart';

class NewNoteScreen extends StatefulWidget {
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              minLines: null,
              decoration: InputDecoration(
                hintText: 'Start writing...',
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Toast.show(
            context,
            'This is a toast message',
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Perform action when the action button is pressed
              },
            ),
          );
          _saveNote();
        },
        child: Icon(Icons.save),
      ),
    );
  }

  void _saveNote() async {
    String title = _titleController.text;
    String description = _descriptionController.text;

    Note note = Note(
      title: title,
      description: description,
      createdAt: DateTime.now(),
      // id: '',
    );

    NoteDatabase database = NoteDatabase();
    await database.insertNote(note);

    _titleController.clear();
    _descriptionController.clear();

    Navigator.pop(context);
  }
}
