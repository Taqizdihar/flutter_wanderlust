import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../models/favorit_provider.dart'; 
import '../widget/kartu_destinasi.dart'; 
import 'root_screen.dart';

class TersimpanScreen extends StatelessWidget {
  const TersimpanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritProvider = Provider.of<FavoritProvider>(context);
    final daftarDestinasi = favoritProvider.daftarFavorit;

    return Scaffold(
      backgroundColor: Colors.teal.shade50, 
      appBar: AppBar(
        backgroundColor: Colors.teal.shade50,
        elevation: 0,
        
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => const RootScreen()),
              );
            }
          },
        ),
        
        title: const Text(
          'Destinasi Tersimpan',
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.teal), 
        ),
        centerTitle: true,
      ),
      
      body: daftarDestinasi.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.bookmark_border,
                      size: 100, 
                      color: Colors.teal.shade300,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Rencanakan Petualangan Anda di Wanderlust!', 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Anda belum menandai destinasi favorit. Tekan ikon simpan pada Beranda untuk mulai merencanakan perjalanan.', 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Cari ikon '),
                        Icon(Icons.bookmark, color: Colors.yellow.shade700, size: 20),
                        const Text(' untuk menyimpan tujuan.')
                      ],
                    ),
                  ],
                ),
              ),
            )
          : 
          ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0), 
              itemCount: daftarDestinasi.length,
              itemBuilder: (context, index) {
                final dest = daftarDestinasi[index];
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [ 
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: KartuDestinasi(
                      nama: dest.nama,
                      lokasi: dest.lokasi,
                      rating: dest.rating,
                      ulasan: dest.ulasan,
                      harga: dest.harga,
                      asetGambar: dest.asetGambar,
                      apakahListTile: true, 
                    ),
                  ),
                );
              },
            ),
    );
  }
}