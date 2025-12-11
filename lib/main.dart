import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Wajib tambahkan package provider di pubspec.yaml

// Import Provider Wisatawan
import 'Wisatawan/models/favorit_provider.dart';

// Import Halaman Login
import 'login.dart';

void main() {
  runApp(
    // Membungkus aplikasi dengan MultiProvider agar data Favorit bisa diakses di mana saja
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wanderlust',
      theme: ThemeData(
        // Menggunakan seed color Teal sesuai desain rekan Anda
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}