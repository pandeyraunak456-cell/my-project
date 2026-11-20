import 'package:flutter/material.dart';
import 'portal_page_shell.dart';

class MyJobsPage extends StatelessWidget {
  const MyJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalPageShell(
      title: 'My Jobs',
      pageIcon: Icons.work,
      content: Column(
        children: const [
          ListTile(title: Text('Flutter Developer'), subtitle: Text('Applied • ABC Technologies'), leading: Icon(Icons.work)),
          Divider(),
          ListTile(title: Text('Python Developer'), subtitle: Text('Under Review • XYZ Solutions'), leading: Icon(Icons.work)),
          Divider(),
          ListTile(title: Text('Frontend Developer'), subtitle: Text('Application Submitted'), leading: Icon(Icons.work)),
        ],
      ),
    );
  }
}