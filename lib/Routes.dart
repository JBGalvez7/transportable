import 'package:flutter/material.dart';
import 'MainScreen.dart';
import 'routes_data.dart';
import 'HelpCenter.dart';
import 'ProfileScreen.dart';
import 'Bookings.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  String selectedType = 'Jeepney';
  int _currentIndex = 1;

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
      case 1:
        // Stay on Routes screen
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HelpCenter()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Booking()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Routes'),
        backgroundColor: Colors.lightBlue[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          // Vehicle Type Buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children:
                  vehicleTypes.map((type) {
                    final isSelected = type == selectedType;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedType = type;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isSelected ? Colors.blueAccent : Colors.grey[300],
                          foregroundColor: Colors.black,
                        ),
                        child: Text(type),
                      ),
                    );
                  }).toList(),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: routesData[selectedType]?.length ?? 0,
              itemBuilder: (context, index) {
                final route = routesData[selectedType]![index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.directions),
                    title: Text('From: ${route['from']} → To: ${route['to']}'),
                    subtitle: Text('Status: ${route['status']}'),
                    trailing: Icon(
                      route['status'] == 'Running'
                          ? Icons.check_circle
                          : Icons.access_time,
                      color:
                          route['status'] == 'Running'
                              ? Colors.green
                              : Colors.orange,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        backgroundColor: Colors.lightBlue.shade100,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Routes'),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_center),
            label: 'Help Center',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Booking',
          ),
        ],
      ),
    );
  }
}
