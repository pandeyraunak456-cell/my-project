import 'package:flutter/material.dart';
import 'portal_page_shell.dart';

class SavedCompaniesPage extends StatelessWidget {
  const SavedCompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalPageShell(
      title: 'Saved Companies',
      pageIcon: Icons.bookmark,
      content: Column(
        children: const [
          ListTile(leading: Icon(Icons.business), title: Text('ABC Technologies'), subtitle: Text('Noida')),
          Divider(),
          ListTile(leading: Icon(Icons.business), title: Text('Tech Solutions'), subtitle: Text('Delhi')),
          Divider(),
          ListTile(leading: Icon(Icons.business), title: Text('Digital India Pvt Ltd'), subtitle: Text('Greater Noida')),
        ],
      ),
    );
  }
}