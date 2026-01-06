import 'package:flutter/material.dart';
import '../models/destinasi_model.dart'; // Menggunakan model Destinasi yang sinkron dengan Laravel
import '../widget/kartu_destinasi.dart'; //
import '../services/api_service.dart'; //
import 'root_screen.dart'; //

class TersimpanScreen extends StatefulWidget {
  final int userId;
  final int idWisatawan;

  const TersimpanScreen({
    super.key, 
    required this.userId, 
    required this.idWisatawan
  });

  @override
  State<TersimpanScreen> createState() => _TersimpanScreenState();
}

class _TersimpanScreenState extends State<TersimpanScreen> {
  late Future<List<Destinasi>> _futureFavorit;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // Mengambil data bookmark asli dari Laravel berdasarkan ID Wisatawan
    _futureFavorit = _apiService.fetchBookmarks(widget.idWisatawan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(
                  // Sinkronisasi parameter RootScreen dengan userId dan idWisatawan
                  builder: (context) => RootScreen(
                    userId: widget.userId, 
                    idWisatawan: widget.idWisatawan
                  )
                ),
              );
            }
          },
        ),
        title: const Text(
          'Destinasi Tersimpan', 
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.teal)
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureFavorit = _apiService.fetchBookmarks(widget.idWisatawan);
          });
        },
        child: FutureBuilder<List<Destinasi>>(
          future: _futureFavorit,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
            }
            
            final daftarDestinasi = snapshot.data ?? [];

            if (daftarDestinasi.isEmpty) {
              return _buildTampilanKosong();
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
              itemCount: daftarDestinasi.length,
              itemBuilder: (context, index) {
                final dest = daftarDestinasi[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: KartuDestinasi(
                    // Memberikan ID destinasi dari database Laravel
                    id: dest.id.toString(),
                    nama: dest.nama,
                    lokasi: dest.lokasi,
                    rating: dest.rating,
                    ulasan: dest.ulasan,
                    harga: dest.harga,
                    // Menggunakan URL gambar dari server (Network Image)
                    asetGambar: dest.gambar, 
                    deskripsi: dest.deskripsi,
                    apakahListTile: true,
                    idWisatawan: widget.idWisatawan, // Diperlukan untuk fitur hapus bookmark
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildTampilanKosong() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 80, color: Colors.teal.withOpacity(0.2)),
          const SizedBox(height: 16),
          const Text(
            "Belum ada destinasi tersimpan",
            style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Destinasi yang kamu simpan akan muncul di sini.",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}