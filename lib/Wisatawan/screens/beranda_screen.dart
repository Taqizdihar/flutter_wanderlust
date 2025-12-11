import 'package:flutter/material.dart';
import '../widget/kartu_destinasi.dart';
import 'profil_screen.dart'; 
import 'pencarian_screen.dart'; 
class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final List<Map<String, dynamic>> semuaDestinasi = [
      { 'nama': 'Kebun Binatang Bandung', 'lokasi': 'Bandung, Jawa Barat', 'rating': 4.3, 'ulasan': 321, 'harga': 50000, 'asetGambar': 'assets/images/bandung_zoo.jpg' },
      { 'nama': 'Tur Lava Merapi', 'lokasi': 'Sleman, Daerah Istimewa Yogyakarta', 'rating': 4.6, 'ulasan': 154, 'harga': 350000, 'asetGambar': 'assets/images/lava_merapi.jpg' },
      { 'nama': 'The Great Asia Africa', 'lokasi': 'Bandung, Jawa Barat', 'rating': 4.0, 'ulasan': 311, 'harga': 44000, 'asetGambar': 'assets/images/The_Great_Asia_Africa.jpg' },
      { 'nama': 'Gunung Bromo', 'lokasi': 'Probolinggo, Jawa Timur', 'rating': 4.5, 'ulasan': 981, 'harga': 125000, 'asetGambar': 'assets/images/mount_bromo.jpg' },
      
      { 'nama': 'Candi Borobudur', 'lokasi': 'Magelang, Jawa Tengah', 'rating': 4.8, 'ulasan': 571, 'harga': 50000, 'asetGambar': 'assets/images/borobudur.jpg' },
      { 'nama': "D'Castello Wisata Flora", 'lokasi': 'Subang, Jawa Barat', 'rating': 4.6, 'ulasan': 229, 'harga': 30000, 'asetGambar': 'assets/images/DCastello.jpg' },
      { 'nama': 'Trans Studio Bandung', 'lokasi': 'Bandung, Jawa Barat', 'rating': 4.5, 'ulasan': 288, 'harga': 200000, 'asetGambar': 'assets/images/trans_studio.jpg' },
      { 'nama': 'Museum Nasional Indonesia', 'lokasi': 'Jakarta Pusat, Jakarta', 'rating': 4.4, 'ulasan': 305, 'harga': 25000, 'asetGambar': 'assets/images/national_museum.jpg' },
    ];

    final List<Map<String, dynamic>> destinasiFavorit = semuaDestinasi.sublist(0, 4); 
    final List<Map<String, dynamic>> destinasiRekomendasi = semuaDestinasi.sublist(4, 8); 

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _bangunHeaderAestetik(context), 
            const SizedBox(height: 10),

            _bangunJudulBagian(context, 'Destinasi Favorit'),
            _bangunDaftarDestinasiHorizontal(destinasiFavorit),
            const SizedBox(height: 20),

            _bangunJudulBagian(context, 'Rekomendasi Destinasi'),
            _bangunDaftarDestinasiHorizontal(destinasiRekomendasi),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _bangunHeaderAestetik(BuildContext context) {
    return Container(
      height: 350,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/aurora.jpg'), 
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.4),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _bangunKolomPencarianDanProfil(context), 
                  const Spacer(),
                  
                  const Text(
                    'Wanderings For Wonders', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  _bangunMenuAksiCepat(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bangunKolomPencarianDanProfil(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/images/Wanderlust Logo Circle.png', 
          height: 45, 
        ),
        
        const SizedBox(width: 10), 

        Expanded(
          child: InkWell( 
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PencarianScreen()), 
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                children: <Widget>[
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Cari Destinasi',
                      style: TextStyle(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 15),
        
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilScreen()), 
            );
          },
          child: const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/faiz.jpg'), 
          ),
        ),
      ],
    );
  }

  Widget _bangunMenuAksiCepat() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _bangunTombolAksiCepat(Icons.location_on, 'Jelajah', () {}),
          _bangunTombolAksiCepat(Icons.receipt, 'Tiket', () {}),
          _bangunTombolAksiCepat(Icons.bookmark, 'Tersimpan', () {}),
          _bangunTombolAksiCepat(Icons.history, 'Riwayat', () {}),
        ],
      ),
    );
  }

  Widget _bangunTombolAksiCepat(IconData ikon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.teal.shade50,
            foregroundColor: Colors.teal,
            radius: 25,
            child: Icon(ikon, size: 24),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _bangunJudulBagian(BuildContext context, String judul) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Text(
        judul,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _bangunDaftarDestinasiHorizontal(List<Map<String, dynamic>> destinasi) {
    return SizedBox(
      height: 280, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemCount: destinasi.length,
        itemBuilder: (context, index) {
          final dest = destinasi[index];
          return KartuDestinasi(
            nama: dest['nama'],
            lokasi: dest['lokasi'],
            rating: dest['rating'],
            ulasan: dest['ulasan'],
            harga: dest['harga'],
            asetGambar: dest['asetGambar'],
            apakahListTile: false, 
          );
        },
      ),
    );
  }
}