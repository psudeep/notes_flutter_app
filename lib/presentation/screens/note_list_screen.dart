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
    );
  }

  Widget _buildNoteCard(BuildContext context, int index) {
    return Dismissible(
      key: Key(index.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Delete'),
              content: Text('Are you sure you want to delete this note?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        // Handle note deletion here
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: ListTile(
          title: Text('Note Title $index'),
          subtitle: Text('Note Description $index'),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Handle edit note action
            },
          ),
        ),
      ),
    );
  }
}
