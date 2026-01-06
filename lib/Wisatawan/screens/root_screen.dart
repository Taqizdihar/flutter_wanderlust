import 'package:flutter/material.dart';
import 'beranda_screen.dart';
import 'tersimpan_screen.dart';
import 'tiket_screens.dart'; // Menambahkan import yang sebelumnya hilang
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

  // Menggunakan getter agar widget layar mendapatkan data terbaru dari widget utama
  List<Widget> get _screens => [
    // Indeks 0: Beranda
    BerandaScreen(
      userId: widget.userId, 
      idWisatawan: widget.idWisatawan
    ),
    // Indeks 1: Tiket      
    TiketScreen(
      userId: widget.userId, 
      idWisatawan: widget.idWisatawan
    ),
    // Indeks 2: Tersimpan             
    TersimpanScreen(
      userId: widget.userId, 
      idWisatawan: widget.idWisatawan
    ),
    // Indeks 3: Placeholder untuk Ulasan / Penilaian    
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
      // Menampilkan layar berdasarkan indeks yang dipilih
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