import 'package:flutter/material.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the actual number of notes
        itemBuilder: (context, index) {
          return _buildNoteCard(context, index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Notes tab selected
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context); // Navigate back to the HomeScreen
          } else if (index == 2) {
            Navigator.pushNamed(
                context, '/settings'); // Navigate to the SettingsScreen
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text('Note Title $index'),
        subtitle: Text('Note Description $index'),
        trailing: Icon(Icons.edit),
        onTap: () {
          // Handle category card click - Navigate to Note Detail Screen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NoteDetailScreen(categoryName: 'Note Title $index')),
          );
        },
      ),
    );
  }
}

class NoteDetailScreen extends StatelessWidget {
  final String categoryName;

  NoteDetailScreen({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Handle share action
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
            onSelected: (value) {
              if (value == 'edit') {
                // Handle edit action
              } else if (value == 'delete') {
                // Handle delete action
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Note Detail'),
      ),
    );
  }
}
