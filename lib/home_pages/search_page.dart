import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchText = '';
  List<String> _searchResults = [];

  void _performSearch(String searchText) {
    List<String> allItems = [
      'Almaty',
      'Dubai',
      'Moscow',
      'New York',
      'London',
      'Karagandy',
    ];
    setState(() {
      _searchResults = allItems
          .where((item) => item.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
                _performSearch(_searchText);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_searchResults[index]),
                  // Add more onTap logic if needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
