import 'package:flutter/material.dart';
import 'booking_history_data.dart';
import 'HelpCenter.dart';
import 'Routes.dart';
import 'ProfileScreen.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 3; // Booking is the fourth tab

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Add your actual navigation logic here
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Routes()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HelpCenter()),
        );
        break;
      case 3:
        // Already in Booking
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2DAEF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 8),
            AnimatedBuilder(
              animation: _tabController,
              builder: (context, _) {
                return Text(
                  _tabController.index == 0 ? 'NOTIFICATIONS' : 'HISTORY',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                );
              },
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: const [Tab(text: "NOTIFICATION"), Tab(text: "HISTORY")],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildNotificationCard(), _buildHistoryList()],
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

  Widget _buildNotificationCard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Booking Notification",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.receipt_long, color: Colors.black54),
                SizedBox(width: 8),
                Text(
                  "Booking #: 1234-5678-9012",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.calendar_today, size: 18, color: Colors.black54),
                SizedBox(width: 8),
                Text("Completed on 2025-05-23 at 12:45 PM"),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 160,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.map, size: 60, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.access_time),
                SizedBox(width: 8),
                Expanded(child: LinearProgressIndicator(value: 0.6)),
                SizedBox(width: 8),
                Text("ETA: 15 mins"),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Trip Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _infoRow("Driver", "Juan Dela Cruz"),
            _infoRow("Vehicle Type", "Jeepney"),
            _infoRow("Plate #", "XFD-4328"),
            _infoRow("Pickup", "Tanqui"),
            _infoRow("Dropoff", "Lorma San Juan"),
            const SizedBox(height: 16),
            const Text(
              "Payment",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _infoRow("Method", "GCash"),
            _infoRow("Additional Fee", "₱5"),
            _infoRow("Total", "₱20"),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text("$title:")),
          Expanded(
            child: Text(
              detail,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookingHistory.length,
      itemBuilder: (context, index) {
        final booking = bookingHistory[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${booking['vehicleType']} - ${booking['bookingNumber']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Text('Date: ${booking['timestamp']}'),
              Text('Plate: ${booking['plateNumber']}'),
              Text('Route: ${booking['route']}'),
              Text('Pickup: ${booking['pickup']}'),
              Text('Dropoff: ${booking['dropoff']}'),
              Text('Total Fee: ₱${booking['fee']}'),
            ],
          ),
        );
      },
    );
  }
}
