import 'package:flutter/material.dart';
import 'package:path/path.dart';

class PurchasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Departure',
                hintText: 'Select your departure',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Destination',
                hintText: 'Select your destination',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Departure Date',
                hintText: 'Select your departure date',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Return Date',
                hintText: 'Select your return date',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Passenger',
                      hintText: 'Select passengers',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Class',
                      hintText: 'Select class',
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
                child: const Text('Search'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Recent searches',
            ),
          ],
        ),
      ),
    );
  }
}

