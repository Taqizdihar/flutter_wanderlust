import 'package:flutter/material.dart';
import 'beranda_screen.dart';
import 'tersimpan_screen.dart';
// Import NoPage dari folder terluar (naik 2 level)
import '../../noPage.dart'; 

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0; 

  final List<Widget> _screens = [
    const BerandaScreen(),      // Index 0: Beranda
    const UnderConstructionPage(), // Index 1: Tiket (Belum ada, arahkan ke NoPage)
    const TersimpanScreen(),    // Index 2: Tersimpan
    const UnderConstructionPage(), // Index 3: Ulasan (Belum ada, arahkan ke NoPage)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], 
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex, 
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Tiket'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Tersimpan'),
          BottomNavigationBarItem(icon: Icon(Icons.star_rate), label: 'Ulasan'),
        ],
        onTap: _onItemTapped, 
      ),
    );
  }
}