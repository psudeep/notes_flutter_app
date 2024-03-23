import 'package:flutter/material.dart';
import '../../data/models/note.dart';
import '../../data/repositories/note_repository.dart';
import '../widgets/note_item.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final NoteRepository _noteRepository = NoteRepository();
  late Future<List<Note>> _notesFuture;

  @override
  void initState() {
    super.initState();
    _notesFuture = _noteRepository.getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: FutureBuilder(
        future: _notesFuture,
        builder: (context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Note> notes = snapshot.data!;
            if (notes.isEmpty) {
              return Center(child: Text('No notes found.'));
            } else {
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return NoteItem(note: notes[index]);
                },
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add note screen
          Navigator.pushNamed(context, '/addNote');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
