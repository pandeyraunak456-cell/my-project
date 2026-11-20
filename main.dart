import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const JobQuicksApp());
}

class JobQuicksApp extends StatelessWidget {
  const JobQuicksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobQuicks',
      theme: ThemeData(
        primaryColor: const Color(0xFF1746A2),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}