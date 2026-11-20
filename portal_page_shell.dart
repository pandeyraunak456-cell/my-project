import 'package:flutter/material.dart';

class PortalPageShell extends StatelessWidget {
  final String title;
  final IconData pageIcon;
  final Widget content;

  const PortalPageShell({
    super.key,
    required this.title,
    required this.pageIcon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF064780),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                pageIcon,
                size: 55,
                color: const Color(0xFF064780),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            content,
          ],
        ),
      ),
    );
  }
}