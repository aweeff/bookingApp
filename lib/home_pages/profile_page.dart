import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/localizations/l10n.dart';

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

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${localizations.translate('name')}: $_name',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              '${localizations.translate('email')}: $_email',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              '${localizations.translate('phone')}: $_phone',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              '${localizations.translate('address')}: $_address',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
