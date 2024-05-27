import 'package:flutter/material.dart';
import 'package:project1/localizations/l10n.dart';

class MyTicketsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.airplane_ticket_outlined,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              localizations.translate('no_tickets'),
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
