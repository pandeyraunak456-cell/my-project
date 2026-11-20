import 'package:flutter/material.dart';
import 'portal_page_shell.dart';

class JobPage extends StatelessWidget {
  const JobPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalPageShell(
      title: 'Find Jobs',
      pageIcon: Icons.work_outline,
      content: Column(
        children: const [
          TextField(decoration: InputDecoration(hintText: 'Search jobs...', prefixIcon: Icon(Icons.search), border: OutlineInputBorder())),
          SizedBox(height: 15),
          ListTile(title: Text('Flutter Developer'), subtitle: Text('ABC Technologies • Noida'), trailing: Text('Apply')),
          Divider(),
          ListTile(title: Text('Python Developer'), subtitle: Text('XYZ Solutions • Delhi'), trailing: Text('Apply')),
          Divider(),
          ListTile(title: Text('UI/UX Designer'), subtitle: Text('Digital Company • Remote'), trailing: Text('Apply')),
        ],
      ),
    );
  }
}