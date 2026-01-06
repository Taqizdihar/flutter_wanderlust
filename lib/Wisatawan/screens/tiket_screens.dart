import 'package:flutter/material.dart';
import '../models/destinasi_model.dart'; // Menggunakan model tunggal Destinasi
import '../services/api_service.dart'; //
import 'package:intl/intl.dart';

class TiketScreen extends StatefulWidget {
  final int userId;
  final int idWisatawan;

  const TiketScreen({
    super.key, 
    required this.userId, 
    required this.idWisatawan
  });

  @override
  State<TiketScreen> createState() => _TiketScreenState();
}

class _TiketScreenState extends State<TiketScreen> {
  late Future<List<Destinasi>> _futureTiket;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // Memanggil API riwayat tiket berdasarkan ID Wisatawan
    _futureTiket = _apiService.fetchUserTickets(widget.idWisatawan);
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID', 
      symbol: 'Rp ', 
      decimalDigits: 0
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Tiket Saya', 
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.teal)
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Destinasi>>(
        future: _futureTiket,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }
          
          final daftarTiket = snapshot.data ?? [];

          return daftarTiket.isEmpty
              ? _bangunTampilanKosong()
              : RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      _futureTiket = _apiService.fetchUserTickets(widget.idWisatawan);
                    });
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: daftarTiket.length,
                    itemBuilder: (context, index) {
                      final tiket = daftarTiket[index];
                      // Membangun kartu tiket dengan data dari database
                      return _bangunKartuTiketAesthetic(context, tiket, formatCurrency);
                    },
                  ),
                );
        },
      ),
    );
  }

  Widget _bangunKartuTiketAesthetic(BuildContext context, Destinasi tiket, NumberFormat formatCurrency) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                // MENGGUNAKAN Image.network untuk gambar dari server
                child: Image.network(
                  tiket.gambar,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Confirmed',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tiket.nama,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 14, color: Colors.teal),
                              const SizedBox(width: 4),
                              Text(tiket.lokasi, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('HARGA TIKET', style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 1.2)),
                        const SizedBox(height: 4),
                        Text(
                          formatCurrency.format(tiket.harga),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.qr_code, size: 18, color: Colors.teal),
                          SizedBox(width: 8),
                          Text('LIHAT TICKET', style: TextStyle(color: Colors.teal, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bangunTampilanKosong() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(color: Colors.teal.withOpacity(0.05), shape: BoxShape.circle),
            child: Icon(Icons.confirmation_num_outlined, size: 80, color: Colors.teal.withOpacity(0.2)),
          ),
          const SizedBox(height: 20),
          const Text('Oops! Belum Ada Tiket', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          const Text('Silakan cari destinasi favoritmu\ndan pesan tiket sekarang.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}