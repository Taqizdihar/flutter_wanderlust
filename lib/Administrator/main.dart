import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'member_list.dart';
import 'property_list.dart';
import 'property_verification.dart';
import 'edit_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Admin Panel",
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: false,
      ),
      home: const DashboardPage(),
      
    );
  }
}
