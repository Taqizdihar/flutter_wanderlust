import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:provider/provider.dart'; 
import '../screens/tersimpan_screen.dart'; 
import '../models/favorit_provider.dart'; 

class KartuDestinasi extends StatelessWidget { 
  final String nama;
  final String lokasi;
  final double rating;
  final int ulasan;
  final int harga;
  final String asetGambar;
  final bool apakahListTile; 

  const KartuDestinasi({
    super.key,
    required this.nama,
    required this.lokasi,
    required this.rating,
    required this.ulasan,
    required this.harga,
    required this.asetGambar,
    this.apakahListTile = false, 
  });

  void _toggleSimpan(BuildContext context) {
    final favoritProvider = Provider.of<FavoritProvider>(context, listen: false);
    final destinasi = DestinasiSederhana(
        nama: nama, lokasi: lokasi, rating: rating,
        ulasan: ulasan, harga: harga, asetGambar: asetGambar,
    );
    bool saatIniTersimpan = favoritProvider.apakahTersimpan(nama);
    favoritProvider.tambahkanHapusFavorit(destinasi);

    if (!saatIniTersimpan) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
            content: Text('$nama ditambahkan ke Favorit!'),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
                label: 'Lihat Favorit',
                textColor: Colors.white,
                onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TersimpanScreen()), 
                );
                },
            ),
            backgroundColor: Colors.teal.shade700,
            ),
        );
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('$nama dihapus dari Favorit.'),
                duration: const Duration(seconds: 2),
            ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritProvider = Provider.of<FavoritProvider>(context);
    bool sudahTersimpan = favoritProvider.apakahTersimpan(nama);

    final pemformat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );
    final hargaTerformat = pemformat.format(harga);

    if (apakahListTile) {
      return Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Image.asset(
                asetGambar,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nama,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 4),
                        Text('$rating (${ulasan} ulasan)', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hargaTerformat,
                      style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton( 
                icon: Icon(
                  sudahTersimpan ? Icons.bookmark : Icons.bookmark_border,
                  color: sudahTersimpan ? Colors.yellow.shade700 : Colors.grey, 
                ),
                onPressed: () => _toggleSimpan(context),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 250,
        margin: const EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    asetGambar,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell( 
                    onTap: () => _toggleSimpan(context), 
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        sudahTersimpan ? Icons.bookmark : Icons.bookmark_border,
                        color: sudahTersimpan ? Colors.yellow.shade700 : Colors.black87, 
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    nama,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text('$rating (${ulasan} ulasan)', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    hargaTerformat,
                    style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4), 
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      lokasi,
                      style: const TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}