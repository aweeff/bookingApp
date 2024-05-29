import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:project1/localizations/l10n.dart';

import '../maps/map_screen.dart';


class City {
  final String code;
  final String name;
  final double latitude;
  final double longitude;

  City(this.code, this.name, this.latitude, this.longitude);

  String localizedName(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return localizations.translate(name);
  }
}



class MyTicketsPage extends StatefulWidget {
  final dynamic user;

  const MyTicketsPage({Key? key, this.user}) : super(key: key);

  @override
  _MyTicketsPageState createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> {
  late List<dynamic> tickets = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

  List<City> cities = [
    City("SCO", "Aktau", 43.65, 51.16),
    City("AKH", "Aktobe", 50.28, 57.21),
    City("ALA", "Almaty", 43.23, 76.85),
    City("NQZ", "Astana", 51.16, 71.43),
    City("GUW", "Atyrau", 47.12, 51.92),
    City("BXY", "Baikonur", 45.62, 63.31),
    City("BHX", "Balkhash", 46.84, 74.98),
    City("DZN", "Jezkazgan", 47.78, 67.77),
    City("KGF", "Karaganda", 49.81, 73.16),
    City("TOUCH", "Kokshetau", 53.28, 69.38),
    City("KSN", "Kostanay", 53.21, 63.63),
    City("KZO", "Kyzylorda", 44.85, 65.51),
    City("PWQ", "Pavlodar", 52.30, 76.97),
    City("PPK", "Petropavlovsk", 54.86, 69.14),
    City("PLX", "Semey", 50.41, 80.23),
    City("NO", "Taldykorgan", 45.00, 78.37),
    City("DMB", "Taraz", 42.90, 71.37),
    City("WATER", "Uralsk", 51.23, 51.37),
    City("FAQ", "Ust-Kamenogorsk", 49.95, 82.61),
    City("CIT", "Shymkent", 42.30, 69.59)
  ];

  City? findCityByCode(String code) {
    return cities.firstWhere(
            (city) => city.code == code,
        orElse: () => City("UNK", "Unknown City",0,0) // Replace "Unknown City" with a key that exists in your localization files if necessary
    );
  }




  Future<void> fetchTickets() async {
    try {
      var response = await http.get(
        Uri.parse(
            'http://192.168.1.28:3000/api/tickets/${widget.user['email']}'), // Adjust URL as needed
      );
      if (response.statusCode == 200) {
        setState(() {
          tickets = jsonDecode(response.body) as List;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load tickets');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : tickets.isEmpty
                  ? Center(
                      child: Text(
                        localizations.translate('no_tickets'),
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    )
                  :ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          var ticket = tickets[index];
          City? departureCity = findCityByCode(ticket['departure']);
          City? destinationCity = findCityByCode(ticket['destination']);

          return ListTile(
            leading: Icon(Icons.airplane_ticket),
            title: Text('${departureCity?.localizedName(context) ?? "Unknown city"} - ${destinationCity?.localizedName(context) ?? "Unknown city"}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${localizations.translate('departure_date')}: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(ticket['departureDate']))}'),
                if (ticket['returnDate'] != null)
                  Text('${localizations.translate('return_date')}: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(ticket['returnDate']))}'),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    departureLatitude: departureCity?.latitude, // Example coordinates for Los Angeles
                    departureLongitude: departureCity?.longitude,
                    destinationLatitude: destinationCity?.latitude, // Example coordinates for New York
                    destinationLongitude: destinationCity?.longitude
                  ),
                ),
              );
            },
          );
        },
      ),

    );
  }
}
