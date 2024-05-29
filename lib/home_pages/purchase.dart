import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Ensure this package is in your pubspec.yaml
import 'package:project1/localizations/l10n.dart';
import 'package:http/http.dart' as http;

class City {
  final String code;
  final String name;
  final double latitude;
  final double longitude;

  City(this.code, this.name, this.latitude, this.longitude);

  // Helper method to fetch a localized name
  String localizedName(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return localizations.translate(name);
  }

  String codeToLocalizedName(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return localizations.translate(code);
  }
}
class PurchasePage extends StatefulWidget {
  final dynamic user;

  const PurchasePage({Key? key, this.user}) : super(key: key);

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {

  String? departure;
  String? destination;
  DateTime? departureDate;
  DateTime? returnDate;
  String? travelClass;
  bool isRoundTrip = true;

  List<City> cities = [
    City("SCO", "Aktau", 43.6614, 51.1975),
    City("AKH", "Aktobe", 50.2839, 57.166),
    City("ALA", "Almaty", 43.222, 76.8512),
    City("NQZ", "Astana", 51.1694, 71.4491),
    City("GUW", "Atyrau", 47.0945, 51.9236),
    City("BXY", "Baikonur", 45.9646, 63.3052),
    City("BHX", "Balkhash", 46.8481, 74.9951),
    City("DZN", "Jezkazgan", 47.786, 67.7081),
    City("KGF", "Karaganda", 49.8047, 73.1094),
    City("TOUCH", "Kokshetau", 53.2833, 69.3833),
    City("KSN", "Kostanay", 53.2194, 63.6319),
    City("KZO", "Kyzylorda", 44.8488, 65.4823),
    City("PWQ", "Pavlodar", 52.2833, 76.9667),
    City("PPK", "Petropavlovsk", 54.8833, 69.1667),
    City("PLX", "Semey", 50.4114, 80.242),
    City("NO", "Taldykorgan", 45.0156, 78.3739),
    City("DMB", "Taraz", 42.9, 71.3667),
    City("WATER", "Uralsk", 51.2333, 51.3667),
    City("FAQ", "Ust-Kamenogorsk", 49.9715, 82.605),
    City("CIT", "Shymkent", 42.3, 69.6),
  ];
  final List<String> classOptions = ['Economy', 'Business', 'First'];
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  TextEditingController departureDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();

  @override
  void dispose() {
    departureDateController.dispose();
    returnDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (isDeparture ? departureDate : returnDate) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          departureDate = picked;
          departureDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        } else {
          returnDate = picked;
          returnDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      });
    }
  }

  Future<void> submitTicketDetails() async {
    if (widget.user['email'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User email is not available')),
      );
      return;
    }
    String email = widget.user['email'];
    var payload = <String, dynamic>{
      'email': email,
      'departure': departure,
      'destination': destination,
      'departureDate': departureDate?.toIso8601String(),
      'travelClass': travelClass,
      'isRoundTrip': isRoundTrip,
    };

    if (isRoundTrip) {
      payload['returnDate'] = returnDate?.toIso8601String();
    }

    var response = await http.post(
      Uri.parse('http://192.168.1.28:3000/api/tickets'), // Change to your actual endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ticket details submitted successfully')),
      );
      print(response.body);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit ticket details: ${response.body}')),
      );
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
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: departure,
              onChanged: (newValue) {
                setState(() => departure = newValue);
              },
              items: cities.map<DropdownMenuItem<String>>((City city) {
                return DropdownMenuItem<String>(
                  value: city.code,
                  child: Text(city.localizedName(context)),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: localizations.translate('departure'),
                hintText: localizations.translate('select_departure'),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: destination,
              onChanged: (newValue) {
                setState(() => destination = newValue);
              },
              items: cities.map<DropdownMenuItem<String>>((City city) {
                return DropdownMenuItem<String>(
                  value: city.code,
                  child: Text(city.localizedName(context)),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: localizations.translate('destination'),
                hintText: localizations.translate('select_destination'),
              ),
            ),
            const SizedBox(height: 10),




            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: localizations.translate('departure_date'),
                hintText: localizations.translate('select_departure_date'),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: departureDateController,
              onTap: () => _selectDate(context, true),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: Text(localizations.translate('round_trip')),
              value: isRoundTrip,
              onChanged: (bool value) {
                setState(() {
                  isRoundTrip = value;
                  if (!isRoundTrip) {
                    returnDate = null;
                    returnDateController.clear();
                  }
                });
              },
            ),
            if (isRoundTrip)
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: localizations.translate('return_date'),
                  hintText: localizations.translate('select_return_date'),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                controller: returnDateController,
                onTap: () => _selectDate(context, false),
              ),



            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: travelClass,
              onChanged: (newValue) => setState(() => travelClass = newValue),
              items: classOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(localizations.translate(value)),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: localizations.translate('class'),
                hintText: localizations.translate('select_class'),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                submitTicketDetails();
              },
              child: const Text(
                'Purchase',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
