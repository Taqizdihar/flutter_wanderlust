import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/favorit_provider.dart';
import '../models/destinasi_model.dart';

class KartuDestinasi extends StatelessWidget {
  final String id; 
  final String nama;
  final String lokasi;
  final double rating;
  final int ulasan;
  final int harga;
  final String asetGambar; 
  final String deskripsi;
  final bool apakahListTile;
  final int? idWisatawan; 

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
                      if (idWisatawan == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Silakan login terlebih dahulu')),
                        );
                        return;
                      }

                      final messenger = ScaffoldMessenger.of(context);

                      bool sukses = await ApiService().simpanPesanan(
                        idWisatawan!, 
                        int.parse(id), 
                        1
                      );

                      if (context.mounted) Navigator.pop(context); 

                      if (sukses) {
                        messenger.showSnackBar(
                          SnackBar(
                            content: Text('Tiket $nama berhasil dipesan! Cek di menu Tiket.'), 
                            backgroundColor: Colors.teal, 
                            behavior: SnackBarBehavior.floating
                          ),
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
                      onPressed: () async {
                        if (idWisatawan == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Silakan login untuk menyimpan favorit')),
                          );
                          return;
                        }

                        bool sukses = await ApiService().toggleBookmark(idWisatawan!, int.parse(id));

                        if (sukses) {
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
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            _buildTextInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInfo() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, size: 14, color: Colors.teal),
              const SizedBox(width: 4),
              Expanded(child: Text(lokasi, style: const TextStyle(color: Colors.grey, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, size: 14, color: Colors.amber),
              const SizedBox(width: 4),
              Text(rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(width: 4),
              Text('($ulasan ulasan)', style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}