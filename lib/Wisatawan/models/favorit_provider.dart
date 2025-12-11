import 'package:flutter/material.dart';

class DestinasiSederhana {
  final String nama;
  final String lokasi;
  final double rating;
  final int ulasan;
  final int harga;
  final String asetGambar;

  DestinasiSederhana({
    required this.nama, required this.lokasi, required this.rating,
    required this.ulasan, required this.harga, required this.asetGambar,
  });
}

class FavoritProvider extends ChangeNotifier {
  final List<DestinasiSederhana> _daftarFavorit = [];

  List<DestinasiSederhana> get daftarFavorit => _daftarFavorit;

  bool apakahTersimpan(String namaDestinasi) {
    return _daftarFavorit.any((item) => item.nama == namaDestinasi);
  }

  void tambahkanHapusFavorit(DestinasiSederhana destinasi) {
    bool isExist = apakahTersimpan(destinasi.nama);

    if (isExist) {
      _daftarFavorit.removeWhere((item) => item.nama == destinasi.nama);
    } else {
      _daftarFavorit.add(destinasi);
    }
    notifyListeners(); 
  }
}