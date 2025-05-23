// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'home_tab.dart';
import 'profile_tab.dart';
import 'help_tab.dart';
import 'settings_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _unreadCount = 3;
  int _selectedIndex = 0;

  static const List<String> _titles = ['Home', 'Profile', 'Help', 'Settings'];
  static final List<Widget> _pages = [
    const HomeTab(),
    const ProfileTab(),
    const HelpTab(),
    const SettingsTab(),
  ];

  void _showNotifications() {
    setState(() => _unreadCount = 0);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        final notifications = [
          {'icon': Icons.school, 'title': 'New Assignment', 'subtitle': 'Math 101 posted Homework 3'},
          {'icon': Icons.event, 'title': 'Exam Schedule', 'subtitle': 'Physics midterm published'},
          {'icon': Icons.message, 'title': 'New Message', 'subtitle': 'Prof. Smith sent you a message'},
        ];
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(),
              ...notifications.map((n) => ListTile(
                    leading: Icon(n['icon'] as IconData, color: Colors.green),
                    title: Text(n['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(n['subtitle'] as String),
                  )),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget header;
    if (_selectedIndex == 0) {
      header = Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF00B374),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Hello!', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                Text('WELCOME MARISTA', style: TextStyle(color: Colors.white70, letterSpacing: 1.1)),
              ],
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                  onPressed: _showNotifications,
                ),
                if (_unreadCount > 0)
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        '$_unreadCount',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    } else if (_selectedIndex == 1) {
      header = _buildProfileHeader();
    } else {
      header = _buildSimpleHeader(_titles[_selectedIndex]);
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      extendBody: true,
      body: SafeArea(
        child: Column(
          children: [header, Expanded(child: _pages[_selectedIndex])],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  SizedBox _buildProfileHeader() {
    return SizedBox(
      height: 140,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFF00B374),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
            ),
            child: const Center(
              child: Text('Profile', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          const Positioned(
            top: 60,
            child: CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/smurf.jpg')),
          ),
        ],
      ),
    );
  }

  Container _buildSimpleHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFF00B374)),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF00B374),
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_titles.length, (idx) {
              final isSelected = idx == _selectedIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = idx),
                child: isSelected
                    ? Row(
                        children: [
                          Icon(_navIcon(idx), color: Colors.white),
                          const SizedBox(width: 4),
                          Text(_titles[idx], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      )
                    : Icon(_navIcon(idx), color: Colors.white70),
              );
            }),
          ),
        ),
      ),
    );
  }

  IconData _navIcon(int idx) {
    switch (idx) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.person;
      case 2:
        return Icons.headset_mic;
      case 3:
        return Icons.settings;
      default:
        return Icons.home;
    }
  }
}
