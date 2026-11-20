import 'package:flutter/material.dart';
import 'portal_page_shell.dart';

class BuildResumePage extends StatelessWidget {
  const BuildResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalPageShell(
      title: 'Build Resume',
      pageIcon: Icons.edit_document,
      content: Column(
        children: const [
          TextField(decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())),
          SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: 'Career Objective', border: OutlineInputBorder())),
          SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: 'Skills', border: OutlineInputBorder())),
          SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: 'Experience', border: OutlineInputBorder())),
          SizedBox(height: 20),
          Text('Resume Builder - Demo UI'),
        ],
      ),
    );
  }
}