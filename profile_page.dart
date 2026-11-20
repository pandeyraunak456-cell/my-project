import 'package:flutter/material.dart';
import 'portal_page_shell.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalPageShell(
      title: 'My Profile',
      pageIcon: Icons.person,
      content: Column(
        children: const [
          CircleAvatar(radius: 45, child: Icon(Icons.person, size: 45)),
          SizedBox(height: 20),
          TextField(decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())),
          SizedBox(height: 15),
          TextField(decoration: InputDecoration(labelText: 'Email Address', border: OutlineInputBorder())),
          SizedBox(height: 15),
          TextField(decoration: InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder())),
          SizedBox(height: 15),
          TextField(decoration: InputDecoration(labelText: 'Education', border: OutlineInputBorder())),
          SizedBox(height: 20),
          Text('Profile details - Demo UI'),
        ],
      ),
    );
  }
}