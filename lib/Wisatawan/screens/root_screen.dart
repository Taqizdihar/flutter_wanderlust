import 'package:flutter/material.dart';
import 'beranda_screen.dart';
import 'tersimpan_screen.dart';
import 'tiket_screens.dart';
import 'profil_screen.dart';
import 'pencarian_screen.dart';

class RootScreen extends StatefulWidget {
  final int userId;
  final int idWisatawan;

  const RootScreen({
    super.key, 
    required this.userId, 
    required this.idWisatawan
  });

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0; 

  List<Widget> get _screens => [
    BerandaScreen(
      userId: widget.userId, 
      idWisatawan: widget.idWisatawan
    ),   
    TiketScreen(
      userId: widget.userId, 
      idWisatawan: widget.idWisatawan
    ),            
    TersimpanScreen(
      userId: widget.userId, 
      idWisatawan: widget.idWisatawan
    ),   
    const SizedBox(
      child: Center(child: Text("Halaman Ulasan dalam Pengembangan")),
    ),            
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: 'Beranda'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt), 
            label: 'Tiket'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark), 
            label: 'Tersimpan'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rate), 
            label: 'Ulasan'
          ),
        ],
        onTap: _onItemTapped, 
      ),
    );
  }
}