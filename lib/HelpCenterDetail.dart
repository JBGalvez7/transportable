import 'package:flutter/material.dart';
import 'ProfileScreen.dart';
import 'Routes.dart';
import 'dart:math';

class HelpCenterDetail extends StatefulWidget {
  final String vehicleType;
  final String vehicleID;
  final int initialTabIndex; // ADD THIS

  const HelpCenterDetail({
    super.key,
    required this.vehicleType,
    this.vehicleID = "",
    this.initialTabIndex = 0, // DEFAULT TO NOTIFICATION TAB
  });

  @override
  State<HelpCenterDetail> createState() => _HelpCenterDetailState();
}

class _HelpCenterDetailState extends State<HelpCenterDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<String> _dummyNotifications;
  late List<Map<String, String>> _dummyMessages;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
    _initializeDummyData();
  }

  String generatePlateNumber() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final rand = Random();
    String letterPart =
        List.generate(3, (_) => letters[rand.nextInt(letters.length)]).join();
    String numberPart = (1000 + rand.nextInt(9000)).toString();
    return '$letterPart-$numberPart';
  }

  void _initializeDummyData() {
    List<String> generatePlates(
      int count,
      String vehicleName,
      String destinationPrefix,
    ) {
      return List.generate(
        count,
        (index) =>
            "The $vehicleName ${generatePlateNumber()} is $destinationPrefix ${index + 1}",
      );
    }

    switch (widget.vehicleType.toUpperCase()) {
      case 'E-JEEPNEYS':
        _dummyNotifications = generatePlates(
          8,
          'E-Jeepney',
          'departing from Stop',
        );
        _dummyMessages = [
          if (widget.vehicleID.isNotEmpty)
            {
              "sender": "user",
              "text": "Regarding vehicle ID: ${widget.vehicleID}",
            },
          {"sender": "user", "text": "I lost my bag in the E-Jeepney earlier."},
          {
            "sender": "system",
            "text": "Please describe your bag or provide a photo.",
          },
          {"sender": "user", "text": "Here's a photo. Plate number: EJ1234"},
          {"sender": "system", "text": "Thank you, we will look into it."},
        ];
        break;
      case 'JEEPNEYS':
        _dummyNotifications = generatePlates(
          8,
          'Jeepney',
          'heading to Terminal',
        );
        _dummyMessages = [
          if (widget.vehicleID.isNotEmpty)
            {
              "sender": "user",
              "text": "Regarding vehicle ID: ${widget.vehicleID}",
            },
          {"sender": "user", "text": "The driver was very kind and helpful."},
          {"sender": "system", "text": "Thank you for your feedback!"},
        ];
        break;
      case 'BUSES':
      default:
        _dummyNotifications = generatePlates(
          8,
          'Bus',
          'going out from Terminal',
        );
        _dummyMessages = [
          if (widget.vehicleID.isNotEmpty)
            {
              "sender": "user",
              "text": "Regarding vehicle ID: ${widget.vehicleID}",
            },
          {
            "sender": "user",
            "text": "Good Afternoon, I forgot my wallet on the bus awhile ago.",
          },
          {
            "sender": "system",
            "text":
                "Good Day, may I know what is the specific design of your wallet?",
          },
          {
            "sender": "user",
            "text":
                "This is the picture of my wallet, The plate number of the bus is AAB",
          },
          {"sender": "system", "text": "We received your concern, thank you."},
        ];
    }
  }

  Color _getThemeColor() {
    switch (widget.vehicleType.toUpperCase()) {
      case 'E-JEEPNEYS':
        return Colors.purple;
      case 'JEEPNEYS':
        return Colors.pink;
      case 'BUSES':
        return Colors.brown;
      default:
        return Colors.grey;
    }
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
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/booking');
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

  @override
  Widget build(BuildContext context) {
    Color themeColor = _getThemeColor();

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
            const SizedBox(),
            AnimatedBuilder(
              animation: _tabController,
              builder: (context, _) {
                return Text(
                  _tabController.index == 0 ? 'NOTIFICATIONS' : 'MESSAGES',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
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
                color: themeColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: const [Tab(text: "NOTIFICATION"), Tab(text: "CONCERN")],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotificationList(themeColor),
                _buildConcernChat(themeColor),
              ],
            ),
          ),
          _buildBottomNavBar(context, 2),
        ],
      ),
    );
  }

  Widget _buildNotificationList(Color themeColor) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _dummyNotifications.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: themeColor.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            _dummyNotifications[index],
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        );
      },
    );
  }

  Widget _buildConcernChat(Color themeColor) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _dummyMessages.length,
            itemBuilder: (context, index) {
              bool isUser = _dummyMessages[index]["sender"] == "user";
              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: isUser ? themeColor : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    _dummyMessages[index]["text"]!,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.add, color: themeColor),
              const SizedBox(width: 10),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: "Type your concern...",
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: themeColor),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
