import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Handle user profile or login action
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
            child: ListView(
              children: [
                _buildCategoryCard(context, 'Fix phlebex api bugs', 0),
                _buildCategoryCard(context, 'max API changes to be done', 1),
                _buildCategoryCard(
                    context, 'regency phase 1 changes to be live', 2),
                // Add more category cards as needed
              ],
            ),
          ),
        ],
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
