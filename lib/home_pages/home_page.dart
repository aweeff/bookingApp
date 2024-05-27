import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_tickets_page.dart';
import 'my_favorites_page.dart';
import 'profile_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
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
          IconButton(
            icon: const Icon(Icons.airplane_ticket_outlined),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyTicketsPage()),
            );},
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {},
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


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBar createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    MyTicketsPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: 'Tickets'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
    ),
    );
  }
}

