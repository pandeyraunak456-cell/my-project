import 'package:flutter/material.dart';
import 'portal_page_shell.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalPageShell(
      title: 'Messenger',
      pageIcon: Icons.message,
      content: Column(
        children: const [
          ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('HR Manager'), subtitle: Text('Interview details')),
          Divider(),
          ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('ABC Technologies'), subtitle: Text('Your application received')),
          Divider(),
          ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('Recruitment Team'), subtitle: Text('Welcome to JobQuicks')),
        ],
      ),
    );
  }
}