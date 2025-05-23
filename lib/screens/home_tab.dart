// lib/screens/home_tab.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../home/grades_screen.dart';
import '../home/schedule_screen.dart';
import '../home/payment_screen.dart';
import '../home/store_screen.dart';

class Announcement {
  final String image;
  final String title;
  final String description;
  Announcement({required this.image, required this.title, required this.description});
}

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  late Timer _timer;
  int _currentPage = 0;

  final List<Map<String, dynamic>> menuItems = [
    {'label': 'GRADES', 'icon': Icons.grade},
    {'label': 'SCHEDULE', 'icon': Icons.calendar_today},
    {'label': 'PAYMENT', 'icon': Icons.payment},
    {'label': 'STORE', 'icon': Icons.store},
  ];

  final List<Announcement> announcements = [
    Announcement(
        image: 'assets/iso.jpg',
        title: 'ISO 21001:2018 Certified',
        description: 'Our university sustains its ISO certification.'),
    Announcement(
        image: 'assets/clearance_req.jpg',
        title: 'Clearance Requirements',
        description: 'Check out clearance steps for 2nd semester.'),
    Announcement(
        image: 'assets/comelec_ext.jpg',
        title: 'Election Extension',
        description: 'Student government voting extended.'),
    Announcement(
        image: 'assets/placeholder4.jpg',
        title: 'Event Coming Up',
        description: 'Join the seminar next week!'),
    Announcement(
        image: 'assets/placeholder5.jpg',
        title: 'Library Update',
        description: 'New books available in the library.'),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % announcements.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void navigateTo(BuildContext context, String section) {
    switch (section) {
      case 'GRADES':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const GradesScreen()));
        break;
      case 'SCHEDULE':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleScreen()));
        break;
      case 'PAYMENT':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentScreen()));
        break;
      case 'STORE':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const StoreScreen()));
        break;
    }
  }

  void openAnnouncement(BuildContext context, Announcement a) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Stack(
          children: [
            Image.asset(a.image, fit: BoxFit.cover),
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(a.description, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Welcome Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0097B2), Color(0xFF7ED957)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('APRIL 30, 2025', style: TextStyle(fontSize: 12, color: Colors.white70)),
                        SizedBox(height: 8),
                        Text('Welcome back, Juan!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('BSCPE - 2', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                  const CircleAvatar(radius: 32, backgroundImage: AssetImage('assets/smurf.jpg')),
                ],
              ),
            ),
          ),

          // 1x4 Feature Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
              children: menuItems.map((item) {
                return GestureDetector(
                  onTap: () => navigateTo(context, item['label'] as String),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF0097B2), Color(0xFF7ED957)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item['icon'] as IconData, size: 28, color: Colors.white),
                        const SizedBox(height: 4),
                        Text(
                          item['label'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

                    // Announcements header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ANNOUNCEMENTS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Announcements carousel
          SizedBox(
            height: 180,
            child: PageView.builder(
              controller: _pageController,
              itemCount: announcements.length,
              itemBuilder: (_, i) {
                final a = announcements[i];
                return GestureDetector(
                  onTap: () => openAnnouncement(context, a),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(a.image, fit: BoxFit.cover),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black54, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: Text(
                              a.title,
                              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Scrollable announcement list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final a = announcements[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GestureDetector(
                  onTap: () => openAnnouncement(context, a),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(a.image, height: 120, width: double.infinity, fit: BoxFit.cover),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(a.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(a.description, style: TextStyle(color: Colors.grey[700])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

