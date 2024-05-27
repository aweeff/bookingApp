import 'package:flutter/material.dart';
import 'package:path/path.dart';

class MyFavoritesPage extends StatefulWidget {
  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  List<Map<String, dynamic>> _favoritesData = [];
  // Method to fetch favorites data from SQLite database

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites'),
      ),
      body: _favoritesData.isNotEmpty
          ? ListView.builder(
        itemCount: _favoritesData.length,
        itemBuilder: (context, index) {
          // Build each item using ListTile or any other desired widget
          return ListTile(
            title: Text(_favoritesData[index]['departure']),
            subtitle: Text(_favoritesData[index]['destination']),
            // Add more fields as needed
          );
        },
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.bookmark_border,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              'No favorites yet',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}