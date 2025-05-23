import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          leading: Icon(Icons.lock, color: Colors.green[700]),
          title: Text('Change Password'),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout, color: Colors.red[700]),
          title: Text('Log Out'),
          onTap: () {},
        ),
      ],
    );
  }
}
