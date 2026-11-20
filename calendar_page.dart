import 'package:flutter/material.dart';
import 'portal_page_shell.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalPageShell(
      title: 'Event Calendar',
      pageIcon: Icons.calendar_month,
      content: Column(
        children: [
          const Text('Upcoming Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          ListTile(leading: const Icon(Icons.event, color: Colors.blue), title: const Text('Job Fair'), subtitle: Text('Date: 10 November 2026')),
          ListTile(leading: const Icon(Icons.event, color: Colors.green), title: const Text('Interview Event'), subtitle: Text('Date: 15 November 2026')),
        ],
      ),
    );
  }
}
