import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNote(Note note) async {
    await _firestore.collection('notes').add({
      'title': note.title,
      'content': note.content,
      'created_at': note.createdAt,
    });
  }

  // Implement other CRUD operations as needed
}
