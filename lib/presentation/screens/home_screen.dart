import 'package:flutter/material.dart';
import 'package:notes_lelo/data/models/note.dart';
import 'package:notes_lelo/presentation/screens/login_screen.dart';
import '../../data/models/note_model.dart';
import '../../data/note_database.dart';
import '../../common/toast.dart';
import '../../common/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    notes = await NoteDatabase.getAllNotesV2();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.description),
                );
              },
            ),
          ),
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
      child: SingleChildScrollView(
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
            SizedBox(height: 16),
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
          _saveNote();
        },
        child: Icon(Icons.save),
      ),
    );
  }

  void _saveNote() {
    // Save the note logic here
    String title = _titleController.text;
    String description = _descriptionController.text;

    // Do something with title and description, such as saving to database
    print('Title: $title');
    print('Description: $description');

    // Clear the text fields after saving
    _titleController.clear();
    _descriptionController.clear();

    // Optionally, navigate back to the previous screen
    Navigator.pop(context);
  }
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
