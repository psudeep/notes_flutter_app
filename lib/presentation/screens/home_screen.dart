import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_lelo/data/models/note.dart';
import 'package:notes_lelo/presentation/screens/login_screen.dart';
import '../../data/models/note_model.dart';
import '../../data/note_database.dart';
import '../../common/toast.dart';
import '../../common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Note {
  final String title;
  final String description;
  final DateTime createdAt;
  final String? category;
  final List<String>? tags;
  DateTime? updatedAt;

  Note({
    required this.title,
    required this.description,
    required this.createdAt,
    this.category,
    this.tags,
    this.updatedAt,
  });

  // Convert Note object to JSON map
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "createdAt": createdAt.toIso8601String()
    };
  }

  // Create Note object from JSON map
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];
  int _selectedTabIndex = 0;
  // List<Note> notes = [];
  // List<Note> notes = [
  //   Note(
  //     // id: 1,
  //     title: 'Note 1',
  //     description: 'Description of Note 1',
  //     createdAt: DateTime.now(),
  //   ),
  //   Note(
  //     // id: 2,
  //     title: 'Note 2',
  //     description: 'Description of Note 2',
  //     createdAt: DateTime.now(),
  //   ),
  //   // Add more dummy notes as needed
  // ];

  @override
  void initState() {
    print('Home Screen Initialized');
    super.initState();
    _fetchNotes(); // Comment this line
    print('Notes: $notes');
    // _initializeDummyNotes(); // Add this line
  }

  void _initializeDummyNotes() {
    notes = [
      Note(
        title: 'Note 1',
        description: 'Description of Note 1',
        createdAt: DateTime.now(),
      ),
      Note(
        title: 'Note 2',
        description: 'Description of Note 2',
        createdAt: DateTime.now(),
      ),
      // Add more dummy notes as needed
    ];
    print(
        'Notes length: ${notes.length}'); // Print the length of the notes list
    print('Notes contents: $notes'); // Print the contents of the notes list
  }

  Future<void> _fetchNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? noteStrings = prefs.getStringList('notes');
    if (noteStrings != null) {
      setState(() {
        notes = noteStrings
            .map((noteString) => Note.fromJson(jsonDecode(noteString)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // initState();
    print('Notes: $notes');
    print('Notes Length: ${notes.length}');
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.homeScreenName),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildUserSection(),
          _buildCategoriesFilter(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle FAB click - Navigate to NewNoteScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewNoteScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
          if (index == 1) {
            // Index 1 corresponds to the "Notes" tab
            Navigator.pushNamed(context, '/notes');
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

  Widget _buildUserSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        'Welcome, User!', // Replace with the logged-in user's name
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCategoriesFilter() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryTab('Personal', 0),
                _buildCategoryTab('ToDo', 1),
                _buildCategoryTab('Work', 2),
                // Add more category tabs as needed
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 10), // Add left margin
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(width: 2, color: Colors.black), // Add underline
              ),
            ),
            child: Text(
              'Recent Notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 120, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailScreen(
                          categoryName: note.title,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 200, // Adjust the width as needed
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title.length > 30
                              ? '${note.title.substring(0, 30)}...'
                              : note.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          note.description.length > 30
                              ? '${note.description.substring(0, 30)}...'
                              : note.description,
                          style: TextStyle(
                            fontSize: 12,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(note.createdAt),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String categoryName, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: _selectedTabIndex == index ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          categoryName,
          style: TextStyle(
            color: _selectedTabIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String categoryName, int index) {
    return GestureDetector(
      onTap: () {
        // Handle category card click - Navigate to Note Detail Screen
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NoteDetailScreen(categoryName: categoryName)),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: ListTile(
          title: Text(categoryName),
        ),
      ),
    );
  }
}

class NewNoteScreen extends StatefulWidget {
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  List<Note> notes = [];
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
            Expanded(
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              flex: 2,
              child: TextField(
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
          // Handle save action
          _addNote();
        },
        child: Icon(Icons.save),
      ),
    );
  }

  Future<void> _saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> noteStrings =
        notes.map((note) => note.toJson()).toList().cast<String>();
    await prefs.setStringList('notes', noteStrings);
  }

  void _addNote() {
    setState(() {
      notes.add(Note(
        title: 'New Note ${notes.length + 1}',
        description: 'Description of new note',
        createdAt: DateTime.now(),
      ));
      _saveNotes();
    });
  }

  // void _saveNote() {
  //   // Save the note logic here
  //   String title = _titleController.text;
  //   String description = _descriptionController.text;

  //   // Do something with title and description, such as saving to database
  //   print('Title: $title');
  //   print('Description: $description');

  //   // Clear the text fields after saving
  //   _titleController.clear();
  //   _descriptionController.clear();

  //   // Optionally, navigate back to the previous screen
  //   Navigator.pop(context);
  // }
}

// Note Detail Screen
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
