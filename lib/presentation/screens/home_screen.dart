import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
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
          _buildUserSection(), // Display user info or welcome message
          _buildCategoriesFilter(), // Sliding categories filter
          // Add other content here
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Initial tab index
        onTap: (index) {
          // Handle tab selection
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
    // Replace this with logic to display user info or welcome message
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.topLeft,
      child: Text(
        'Welcome!',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCategoriesFilter() {
    // Replace this with the sliding categories filter implementation
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildCategoryItem('Personal'),
            _buildCategoryItem('Journal'),
            _buildCategoryItem('ToDo'),
            _buildCategoryItem('Work'),
            // Add more category items as needed
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String categoryName) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        categoryName,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
