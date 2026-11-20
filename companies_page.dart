import 'package:flutter/material.dart';
import 'portal_page_shell.dart';

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalPageShell(
      title: 'Companies',
      pageIcon: Icons.apartment,
      content: Column(
        children: const [
          ListTile(leading: Icon(Icons.business), title: Text('ABC Technologies'), subtitle: Text('Technology Company')),
          Divider(),
          ListTile(leading: Icon(Icons.business), title: Text('Infosys'), subtitle: Text('IT Services')),
          Divider(),
          ListTile(leading: Icon(Icons.business), title: Text('TCS'), subtitle: Text('IT Services')),
        ],
      ),
    );
  }
}