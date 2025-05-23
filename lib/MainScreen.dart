import 'package:flutter/material.dart';
import 'package:transportable/HelpCenter.dart';
import 'package:transportable/ProfileScreen.dart';
import 'Routes.dart';
import 'ProfileScreen.dart';
import 'package:transportable/Login.dart';
import 'Bookings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final Map<String, Map<String, dynamic>> vehicleDataMap = {
    "Bus 1": {
      'type': 'Bus',
      'name': 'Carlos D. Reyes',
      'id': 'B123456789',
      'plate': 'XYZ 5678',
      'available': true,
      'from': 'San Fernando',
      'to': 'BAUANG',
    },
    "Bus 2": {
      'type': 'Bus',
      'name': 'Maria L. Gomez',
      'id': 'B987654321',
      'plate': 'LMN 1234',
      'available': false,
      'from': 'CHOWKING',
      'to': 'CSI Mall',
    },
    "Jeep 1": {
      'type': 'Jeep',
      'name': 'Julio P. Cruz',
      'id': 'J1122334455',
      'plate': 'JPX 3421',
      'available': true,
      'from': 'San Juan',
      'to': 'Lingsat',
    },
    "Jeep 2": {
      'type': 'Jeep',
      'name': 'Elena R. Santos',
      'id': 'J9988776655',
      'plate': 'JEP 9087',
      'available': false,
      'from': 'Catbangen',
      'to': 'Biday',
    },
    "Tricycle 1": {
      'type': 'Tricycle',
      'name': 'Leandro P. Reyes',
      'id': 'T14467890123',
      'plate': 'QPX 2485',
      'available': true,
      'current': 'Burgos St.',
    },
    "Tricycle 2": {
      'type': 'Tricycle',
      'name': 'Isabel G. Mendoza',
      'id': 'T18822333444',
      'plate': 'TRX 1123',
      'available': false,
      'current': 'Rizal Ave.',
    },
  };

  final List<Widget> _pages = [
    ProfileScreen(),
    Routes(),
    HelpCenter(),
    Booking(),
  ];

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        // Stay on current screen or go to Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Routes()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HelpCenter()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Booking()),
        );
        break;
      default:
        break;
    }
  }

  void _showVehicleInfo(String vehicleKey) {
    final vehicleData = vehicleDataMap[vehicleKey];

    if (vehicleData == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => DraggableScrollableSheet(
            initialChildSize: 0.68,
            maxChildSize: 0.95,
            minChildSize: 0.4,
            builder:
                (_, controller) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "VEHICLE INFO",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.red[200],
                                  child: Icon(
                                    vehicleData['type'] == 'Tricycle'
                                        ? Icons.pedal_bike
                                        : vehicleData['type'] == 'Bus'
                                        ? Icons.directions_bus
                                        : Icons.local_shipping,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 5,
                                    children: [
                                      Text(
                                        "NAME: ${vehicleData['name']}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "ID: ${vehicleData['id']}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "PLATE #: ${vehicleData['plate']}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.lightBlue[100],
                                        ),
                                        icon: Icon(
                                          Icons.message,
                                          color: Colors.black,
                                        ),
                                        label: Text(
                                          "Message",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ROUTE SECTION
                              Row(
                                children: [
                                  Icon(Icons.route, color: Colors.blueAccent),
                                  SizedBox(width: 8),
                                  Text(
                                    vehicleData['type'] == 'Tricycle'
                                        ? "CURRENT ROUTE"
                                        : "SCHEDULED ROUTE",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              if (vehicleData['type'] == 'Tricycle')
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      vehicleData['current'],
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                )
                              else
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_upward,
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "From: ${vehicleData['from']}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_downward,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "To: ${vehicleData['to']}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                              Divider(height: 24, thickness: 1),

                              // PASSENGER STATUS SECTION
                              Row(
                                children: [
                                  Icon(Icons.person, color: Colors.purple),
                                  SizedBox(width: 8),
                                  Text(
                                    "VEHICLE PASSENGER STATUS",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(),
                              Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      vehicleData['available']
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color:
                                          vehicleData['available']
                                              ? Colors.green
                                              : Colors.red,
                                      size: 48,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      vehicleData['available']
                                          ? "Driver is accepting passengers"
                                          : "Vehicle is full",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(height: 2),
                                    ElevatedButton.icon(
                                      onPressed:
                                          vehicleData['available']
                                              ? () {
                                                // Booking logic
                                              }
                                              : null,
                                      icon: Icon(Icons.check),
                                      label: Text(
                                        vehicleData['available']
                                            ? "BOOK VEHICLE"
                                            : "CANNOT BOOK THIS VEHICLE",
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            vehicleData['available']
                                                ? Colors.lightBlue[100]
                                                : Colors.grey[400],
                                        foregroundColor: Colors.black,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 12,
                                        ),
                                        textStyle: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  void _openLeftSidebar() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => Center(
            child: SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 230,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Image.asset(
                          'assets/transportable_logo.png',
                          height: 150,
                          width: 150,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _sidebarButton(Icons.person, 'PROFILE', 0),
                      _sidebarButton(Icons.route, 'ROUTES', 1),
                      _sidebarButton(Icons.help_center, 'HELP CENTER', 2),
                      _sidebarButton(Icons.book_online, 'BOOKING', 3),
                      const Spacer(),
                      _userProfileSection(),
                      _logoutButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }

  Widget _sidebarButton(IconData icon, String label, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(48),
          backgroundColor: Colors.lightBlue[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(icon, color: Colors.black),
        label: Text(label, style: TextStyle(color: Colors.black)),
        onPressed: () {
          Navigator.pop(context);
          _onItemTapped(index);
        },
      ),
    );
  }

  Widget _userProfileSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(color: Colors.black87),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'User123',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'user12@gmail.com',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _logoutButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size.fromHeight(45),
        ),
        icon: const Icon(Icons.logout, color: Colors.black),
        label: const Text('LOG OUT', style: TextStyle(color: Colors.black)),
        onPressed: _showLogoutDialog,
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Colors.lightBlue[100],
            title: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                child: const Text('Yes'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/map_screen.png', fit: BoxFit.cover),
          ),

          Positioned(
            top: 120,
            left: 80,
            child: GestureDetector(
              onTap: () => _showVehicleInfo("Bus 1"),
              child: Icon(Icons.directions_bus, color: Colors.red, size: 32),
            ),
          ),
          Positioned(
            top: 220,
            left: 160,
            child: GestureDetector(
              onTap: () => _showVehicleInfo("Bus 2"),
              child: Icon(Icons.directions_bus, color: Colors.red, size: 32),
            ),
          ),

          Positioned(
            top: 180,
            left: 250,
            child: GestureDetector(
              onTap: () => _showVehicleInfo("Jeep 1"),
              child: Icon(Icons.local_shipping, color: Colors.pink, size: 32),
            ),
          ),
          Positioned(
            top: 300,
            left: 120,
            child: GestureDetector(
              onTap: () => _showVehicleInfo("Jeep 2"),
              child: Icon(Icons.local_shipping, color: Colors.pink, size: 32),
            ),
          ),

          Positioned(
            top: 340,
            left: 200,
            child: GestureDetector(
              onTap: () => _showVehicleInfo("Tricycle 1"),
              child: Icon(Icons.pedal_bike, color: Colors.blue, size: 32),
            ),
          ),
          Positioned(
            top: 100,
            left: 220,
            child: GestureDetector(
              onTap: () => _showVehicleInfo("Tricycle 2"),
              child: Icon(Icons.pedal_bike, color: Colors.blue, size: 32),
            ),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: _openLeftSidebar,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ),
        ],
      ),

      // Bottom nav bar
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
