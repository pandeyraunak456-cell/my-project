import 'package:flutter/material.dart';

// Import all pages
import 'profile_page.dart';
import 'resume_page.dart';
import 'my_jobs_page.dart';
import 'saved_companies_page.dart';
import 'calendar_page.dart';
import 'message_page.dart';
import 'job_page.dart';
import 'companies_page.dart';
import 'build_resume_page.dart';
import 'training_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardHome();
  }
}

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  final Color primary = const Color(0xFF064780);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F6FD),

      appBar: AppBar(
        title: const Text('JobQuicks Dashboard'),
        backgroundColor: const Color(0xFF064780),
        foregroundColor: Colors.white,
      ),

      drawer: Drawer(
        width: 290,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                color: const Color(0xFF064780),
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.work,
                        size: 40,
                        color: Color(0xFF064780),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'JobQuicks',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Job Portal App',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  children: [
                    menuItem(context, Icons.dashboard, 'Dashboard', null),
                    menuItem(context, Icons.person, 'Profile', const ProfilePage()),
                    menuItem(context, Icons.description, 'Resume', const ResumePage()),
                    menuItem(context, Icons.work, 'My Jobs', const MyJobsPage()),
                    menuItem(context, Icons.bookmark, 'Saved Companies', const SavedCompaniesPage()),
                    menuItem(context, Icons.calendar_month, 'Event Calendar', const CalendarPage()),
                    menuItem(context, Icons.message, 'Messenger', const MessagePage()),
                    menuItem(context, Icons.business_center, 'Jobs', const JobPage()),
                    menuItem(context, Icons.apartment, 'Companies', const CompaniesPage()),
                    menuItem(context, Icons.edit_document, 'Build Resume', const BuildResumePage()),
                    menuItem(context, Icons.school, 'Training', const TrainingPage()),
                  ],
                ),
              ),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to JobQuicks!',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            dashboardCard('Applied Jobs', '0', Icons.send, Colors.blue),
            dashboardCard('Saved Jobs', '0', Icons.bookmark, Colors.orange),
            dashboardCard('Shortlisted Jobs', '0', Icons.star, Colors.green),
            dashboardCard('Interviews', '0', Icons.people, Colors.purple),

            const SizedBox(height: 20),

            const Text(
              'Recommended Jobs',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            jobCard('Flutter Developer', 'ABC Technologies', 'Noida'),
            jobCard('Python Developer', 'XYZ Solutions', 'Delhi'),
            jobCard('Frontend Developer', 'Tech Company', 'Greater Noida'),

            const SizedBox(height: 20),

            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Job application submitted'),
            ),

            const ListTile(
              leading: Icon(Icons.bookmark, color: Colors.blue),
              title: Text('New job saved'),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(
    BuildContext context,
    IconData icon,
    String title,
    Widget? page,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF064780)),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);

        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
    );
  }

  Widget dashboardCard(
    String title,
    String number,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.12),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        trailing: Text(
          number,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget jobCard(String title, String company, String location) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.business_center),
        ),
        title: Text(title),
        subtitle: Text('$company • $location'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}