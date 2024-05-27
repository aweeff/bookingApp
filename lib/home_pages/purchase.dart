import 'package:flutter/material.dart';
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}