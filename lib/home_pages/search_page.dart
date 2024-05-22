import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchText = '';
  List<String> _searchResults = [];
  final List<String> _allItems = [
    'Almaty',
    'Dubai',
    'Moscow',
    'New York',
    'London',
    'Karagandy',
  ];

  void _performSearch(String searchText) {
    setState(() {
      _searchResults = _allItems
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
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                _searchText = value;
                _performSearch(_searchText);
              },
            ),
          ),
          Expanded(
            child: _searchResults.isEmpty && _searchText.isNotEmpty
                ? Center(child: Text('No results found'))
                : ListView.builder(
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
