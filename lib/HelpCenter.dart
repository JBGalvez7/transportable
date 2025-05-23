import 'package:flutter/material.dart';
import 'HelpCenterDetail.dart';
import 'Bookings.dart';
import 'Routes.dart';
import 'ProfileScreen.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

  void _navigateToDetail(BuildContext context, String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HelpCenterDetail(vehicleType: type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2DAEF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Help Center",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 140,
                child: const Image(
                  image: AssetImage('assets/transportable_logo.png'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Text(
                  "Select your vehicle type below to view recent updates or send a concern to our team.",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Text(
                  "Choose Vehicle Type",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              _buildVehicleButton(
                context,
                "E-JEEPNEYS",
                Colors.purple,
                Icons.electric_rickshaw,
              ),
              _buildVehicleButton(
                context,
                "JEEPNEYS",
                Colors.pink,
                Icons.directions_bus,
              ),
              _buildVehicleButton(
                context,
                "BUSES",
                Colors.brown.shade800,
                Icons.directions_transit,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.help_outline, color: Colors.blueAccent),
                    title: const Text("Need more help?"),
                    subtitle: const Text(
                      "View our FAQ or contact us directly.",
                    ),
                    onTap: () {
                      // Navigate to FAQ or contact support
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context, 2),
    );
  }

  Widget _buildVehicleButton(
    BuildContext context,
    String title,
    Color color,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: InkWell(
        onTap: () => _navigateToDetail(context, title),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Routes()),
            );
            break;
          case 2:
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Booking()),
            );
            break;
        }
      },
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
    );
  }
}
