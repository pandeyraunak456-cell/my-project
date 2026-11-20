import 'package:flutter/material.dart';
import 'portal_page_shell.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalPageShell(
      title: 'Training',
      pageIcon: Icons.school,
      content: Column(
        children: const [
          ListTile(leading: Icon(Icons.code), title: Text('Flutter Development'), subtitle: Text('Mobile App Development')),
          Divider(),
          ListTile(leading: Icon(Icons.computer), title: Text('Python Programming'), subtitle: Text('Programming Fundamentals')),
          Divider(),
          ListTile(leading: Icon(Icons.smart_toy), title: Text('Artificial Intelligence'), subtitle: Text('AI & Machine Learning')),
        ],
      ),
    );
  }
}