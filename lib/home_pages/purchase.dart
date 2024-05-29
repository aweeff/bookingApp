import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Ensure this package is in your pubspec.yaml
import 'package:project1/localizations/l10n.dart';


class City {
  final String code;
  final String name;

  City(this.code, this.name);

  // Helper method to fetch a localized name
  String localizedName(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return localizations.translate(name);
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
    City("SCO", "Aktau"),
    City("AKH", "Aktobe"),
    City("LAND", "Almaty"),
    City("NQZ", "Astana"),
    City("GUW", "Atyrau"),
    City("BXY", "Baikonur"),
    City("BHX", "Balkhash"),
    City("DZN", "Jezkazgan"),
    City("KGF", "Karaganda"),
    City("TOUCH", "Kokshetau"),
    City("KSN", "Kostanay"),
    City("KZO", "Kyzylorda"),
    City("PWQ", "Pavlodar"),
    City("PPK", "Petropavlovsk"),
    City("PLX", "Semey"),
    City("NO", "Taldykorgan"),
    City("DMB", "Taraz"),
    City("WATER", "Uralsk"),
    City("FAQ", "Ust-Kamenogorsk"),
    City("CIT", "Shymkent")
  ];
  final List<String> classOptions = ['Economy', 'Business', 'First'];
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDeparture ? (departureDate ?? DateTime.now()) : (returnDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          departureDate = picked;
        } else {
          returnDate = picked;
        }
      });
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
            GestureDetector(
              onTap: () => _selectDate(context, true),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: localizations.translate('departure_date'),
                    hintText: localizations.translate('select_departure_date'),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(text: departureDate == null ? '' : dateFormat.format(departureDate!)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: Text(localizations.translate('round_trip')),
              value: isRoundTrip,
              onChanged: (bool value) {
                setState(() {
                  isRoundTrip = value;
                  if (!isRoundTrip) {
                    returnDate = null; // Clear return date when toggling off round trip
                  }
                });
              },
            ),
            if (isRoundTrip)
              GestureDetector(
                onTap: () => _selectDate(context, false),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: localizations.translate('return_date'),
                      hintText: localizations.translate('select_return_date'),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(text: returnDate == null ? '' : dateFormat.format(returnDate!)),
                  ),
                ),
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
          ],
        ),
      ),
    );
  }
}
