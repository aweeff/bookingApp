import 'package:flutter/material.dart';
import 'package:project1/localizations/l10n.dart';

class MyFavoritesPage extends StatefulWidget {
  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  List<Map<String, dynamic>> _favoritesData = [];

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('my_favorites')),
      ),
      body: _favoritesData.isNotEmpty
          ? ListView.builder(
        itemCount: _favoritesData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_favoritesData[index]['departure']),
            subtitle: Text(_favoritesData[index]['destination']),
          );
        },
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.bookmark_border,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              localizations.translate('no_favorites'),
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
