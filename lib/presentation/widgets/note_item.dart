//Widget file for displaying a single note item.

import 'package:flutter/material.dart';
import '../../data/models/note.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  NoteItem({required this.note});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.title),
      subtitle: Text(note.description),
      trailing: Text(
        '${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}',
      ),
      onTap: () {
        // Add functionality to navigate to note detail screen
      },
    );
  }
}
