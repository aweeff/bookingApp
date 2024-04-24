import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PurchasePage extends StatefulWidget {
  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = {
    'departure': '',
    'destination': '',
    'departureDate': '',
    'returnDate': '',
    'passengers': '',
    'class': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Tickets'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Departure'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter departure';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['departure'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Destination'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter destination';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['destination'] = value!;
                  },
                ),
                // Add more form fields for departure date, return date, passengers, class, etc.
                // Remember to add validators and onSaved handlers for each field
                // Example:
                TextFormField(
                  decoration: InputDecoration(labelText: 'Departure Date'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter departure date';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['departureDate'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Return Date'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter return date';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['returnDate'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Passengers'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter number of passengers';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['passengers'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Class'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter class';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['class'] = value!;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save form data
                      _formKey.currentState!.save();
                      // Save the form data to SQLite database
                      _saveFormDataToSQLite(_formData);
                      // Reset the form
                      _formKey.currentState!.reset();
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to save form data into SQLite
  void _saveFormDataToSQLite(Map<String, dynamic> formData) async {
    // Open the SQLite database
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'flight_database.db'),
    );

    // Insert the form data into the database
    await database.insert(
      'flights', // Table name
      formData,
      conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts if any
    );

    // Close the database
    await database.close();

    // Show a snackbar or navigate to a different page to indicate successful save
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Text('Flight details saved.'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}