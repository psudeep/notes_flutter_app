import 'package:notes_lelo/data/note_database.dart';

import '../../data/models/note.dart';
// import 'package:your_app/data/local/note_database.dart';

class NoteRepository {
  final NoteDatabase _noteDatabase = NoteDatabase();

  Future<List<Note>> getAllNotes() async {
    return await _noteDatabase.getAllNotes();
  }

  Future<void> addNote(Note note) async {
    await _noteDatabase.insertNote(note);
  }

  Future<void> updateNote(Note note) async {
    await _noteDatabase.updateNote(note);
  }

  // Future<void> deleteNoteById(int id) async {
  //   await _noteDatabase.deleteNoteById(id);
  // }
}
