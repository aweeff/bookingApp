import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:project1/themes/theme_provider.dart';
import 'package:project1/themes/themes.dart';// Ensure you have the correct path for your theme_provider.dart

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _address = '';

  @override
  void initState() {
    super.initState();
    // Fetch user profile data when the page loads
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/profile')); // Update with your backend endpoint
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _name = data['name'];
          _email = data['email'];
          _phone = data['phone'];
          _address = data['address'];
        });
      } else {
        // Handle error
        print('Failed to fetch user profile: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Error fetching user profile: $e');
    }
  }

  void _changeTheme(ThemeData theme) {
    Provider.of<ThemeProvider>(context, listen: false).setTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'Light') {
                _changeTheme(lightTheme);
              } else if (value == 'Dark') {
                _changeTheme(darkTheme);
              } else if (value == 'Custom') {
                _changeTheme(customColorfulTheme);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Light', 'Dark', 'Custom'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $_name',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email: $_email',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: $_phone',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Address: $_address',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
