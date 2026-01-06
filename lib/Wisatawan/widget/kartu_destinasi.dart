import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/favorit_provider.dart';
import '../models/destinasi_model.dart'; // Menggunakan model Destinasi baru

class KartuDestinasi extends StatelessWidget {
  final String id; // ID Wisata dari Laravel
  final String nama;
  final String lokasi;
  final double rating;
  final int ulasan;
  final int harga;
  final String asetGambar; // Sekarang berisi URL Network
  final String deskripsi;
  final bool apakahListTile;
  final int? idWisatawan; // Tambahkan ini untuk keperluan API

  const KartuDestinasi({
    super.key,
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.rating,
    required this.ulasan,
    required this.harga,
    required this.asetGambar,
    required this.deskripsi,
    this.apakahListTile = false,
    this.idWisatawan,
  });

  void _tampilkanDetail(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nama, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(deskripsi, style: const TextStyle(fontSize: 14, color: Colors.black87)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatCurrency.format(harga), style: const TextStyle(fontSize: 18, color: Colors.teal, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      
                      // Menyiapkan data untuk dikirim ke API Laravel
                      // Catatan: id tiket di sini diasumsikan sama dengan id wisata untuk simulasi awal
                      bool sukses = await ApiService().simpanPesanan(
                        idWisatawan ?? 0, 
                        int.parse(id), 
                        1
                      );

                      if (context.mounted) Navigator.pop(context); 

                      if (sukses) {
                        messenger.showSnackBar(
                          SnackBar(content: Text('Berhasil memesan tiket ke $nama!'), backgroundColor: Colors.teal, behavior: SnackBarBehavior.floating),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                    child: const Text('Pesan Sekarang'),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoritProvider = Provider.of<FavoritProvider>(context);
    // Cek favorit berdasarkan ID (int) agar lebih akurat
    bool isSaved = favoritProvider.apakahTersimpan(int.parse(id));

    return InkWell(
      onTap: () => _tampilkanDetail(context),
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  // MENGGUNAKAN Image.network untuk data dari Laravel
                  child: Image.network(
                    asetGambar, 
                    height: 140, 
                    width: double.infinity, 
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 140, 
                      color: Colors.grey[300], 
                      child: const Icon(Icons.image_not_supported)
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    radius: 18,
                    child: IconButton(
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.teal,
                        size: 20,
                      ),
                      onPressed: () {
                        favoritProvider.tambahkanHapusFavorit(Destinasi(
                          id: int.parse(id), 
                          nama: nama, 
                          lokasi: lokasi, 
                          rating: rating,
                          ulasan: ulasan, 
                          harga: harga, 
                          gambar: asetGambar, 
                          deskripsi: deskripsi
                        ));
                      },
                    ),
                  ),
                ),
              ],
            ),
            // ... (Bagian teks tetap sama)
          ],
        ),
      ),
    );
  }
}