import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/localizations/l10n.dart';

class ProfilePage extends StatefulWidget {
  final dynamic user;
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, dynamic> user;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    _nameController = TextEditingController(text: user['name'] ?? '');
    _emailController = TextEditingController(text: user['email'] ?? '');
    _phoneController = TextEditingController(text: user['phone'] ?? '');
    _addressController = TextEditingController(text: user['address'] ?? '');
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.201.4.144:3000/api/fetchProfile?email=${user['email']}'),
      );
      if (response.statusCode == 200) {
        setState(() {
          user = jsonDecode(response.body);
          _nameController.text = user['name'];
          _emailController.text = user['email'];
          _phoneController.text = user['phone'];
          _addressController.text = user['address'];
        });
      } else {
        print('Failed to fetch user profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.202.8.249:3000/api/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mainmail': user["email"],
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
        }),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Updated Successfully!')));
        fetchUserProfile(); // Refetch the user profile to update the UI
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

    body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
    children: [
    TextField(
    controller: _nameController,
    decoration: const InputDecoration(
    labelText: 'name' ?? 'Name',
    ),
      onChanged: (value) {
        user['name'] = value; // This updates your local user map immediately
      },
    ),
    TextField(
    controller: _emailController,
    decoration: const InputDecoration(
    labelText: 'email' ?? 'Email',
    ),
      onChanged: (value) {
        user['email'] = value; // This updates your local user map immediately
      },
    ),
    TextField(
    controller: _phoneController,
    decoration: const InputDecoration(
    labelText: 'phone' ?? 'Phone',
    ),
      onChanged: (value) {
        user['phone'] = value; // This updates your local user map immediately
      },
    ),
    TextField(
    controller: _addressController,
    decoration: const InputDecoration(
    labelText: 'address' ?? 'Address',
    ),
      onChanged: (value) {
        user['address'] = value; // This updates your local user map immediately
      },
    ),
    ElevatedButton(
    onPressed: _updateUserProfile,
    child: const Text('applyChanges' ?? 'Apply Changes'),
    ),]
    ))
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
