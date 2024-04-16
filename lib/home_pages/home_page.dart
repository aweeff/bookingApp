import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
          },
        ),

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.bookmark_add_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.airplane_ticket_outlined),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {},
            itemBuilder: (BuildContext context) {
              return {'Option 1', 'Option 2', 'Option 3'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],


      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[


            Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.blue
                /*image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/background_image.jpg'),
                ),*/
              ),
            ),


            Padding(
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
                      onPressed: () {},
                      child: const Text('Search'),
                    ),
                  ),
                  const Text(
                    'Recent searches',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
