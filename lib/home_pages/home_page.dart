import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../main.dart';
import 'my_tickets_page.dart';
import 'my_favorites_page.dart';
import 'profile_page.dart';
import 'purchase.dart';
import 'package:project1/maps/map_screen.dart'; // Import the MapScreen

import 'package:project1/themes/theme_provider.dart';
import 'package:project1/themes/themes.dart';

class HomePage extends StatefulWidget {
  final dynamic user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _changeTheme(ThemeData theme) {
    Provider.of<ThemeProvider>(context, listen: false).setTheme(theme);
  }

  int _currentIndex = 0;
  final List<Widget> _pages = [
    PurchasePage(),
    MyTicketsPage(),
    MapScreen(), // Add MapScreen here
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JetJoy'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.bookmark_add_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyFavoritesPage()),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'Light') {
                _changeTheme(lightTheme);
              } else if (value == 'Dark') {
                _changeTheme(darkTheme);
              } else if (value == 'Custom') {
                _changeTheme(customColorfulTheme);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Light', 'Dark', 'Custom'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: Icon(Icons.sunny),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              Locale newLocale;
              switch (value) {
                case 'KAZ':
                  newLocale = Locale('kk');
                  break;
                case 'RUS':
                  newLocale = Locale('ru');
                  break;
                default:
                  newLocale = Locale('en');
              }
              MyApp.of(context)!.setLocale(newLocale);
            },
            itemBuilder: (BuildContext context) {
              return {'KAZ', 'RUS', 'ENG'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.blue,  // Set the color for the selected icon
        unselectedItemColor: Colors.blue, // Set the color for the unselected icons
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.flight), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'), // Add a new tab for the map
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
