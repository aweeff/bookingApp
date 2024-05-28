import 'package:flutter/material.dart';
import 'package:project1/localizations/l10n.dart';

class PurchasePage extends StatefulWidget {
  final dynamic user;

  const PurchasePage({Key? key, this.user}) : super(key: key);
  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  String? departure;
  String? destination;
  String? departureDate;
  String? returnDate;
  String? passenger;
  String? travelClass;

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              onChanged: (value) => setState(() => departure = value),
              decoration: InputDecoration(
                labelText: localizations.translate('departure'),
                hintText: localizations.translate('select_departure'),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) => setState(() => destination = value),
              decoration: InputDecoration(
                labelText: localizations.translate('destination'),
                hintText: localizations.translate('select_destination'),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) => setState(() => departureDate = value),
              decoration: InputDecoration(
                labelText: localizations.translate('departure_date'),
                hintText: localizations.translate('select_departure_date'),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) => setState(() => returnDate = value),
              decoration: InputDecoration(
                labelText: localizations.translate('return_date'),
                hintText: localizations.translate('select_return_date'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    onChanged: (value) => setState(() => passenger = value),
                    decoration: InputDecoration(
                      labelText: localizations.translate('passenger'),
                      hintText: localizations.translate('select_passengers'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    onChanged: (value) => setState(() => travelClass = value),
                    decoration: InputDecoration(
                      labelText: localizations.translate('class'),
                      hintText: localizations.translate('select_class'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add your search logic here
                },
                child: Text(localizations.translate('search')),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              localizations.translate('recent_searches'),
            ),
          ],
        ),
      ),
    );
  }
}
