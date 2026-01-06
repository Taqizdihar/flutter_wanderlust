import 'package:flutter/material.dart';
import 'destinasi_model.dart'; // Gunakan model tunggal

class FavoritProvider extends ChangeNotifier {
  final List<Destinasi> _daftarFavorit = [];
  List<Destinasi> get daftarFavorit => _daftarFavorit;

  bool apakahTersimpan(int idDestinasi) {
    return _daftarFavorit.any((item) => item.id == idDestinasi);
  }

  void tambahkanHapusFavorit(Destinasi destinasi) {
    if (apakahTersimpan(destinasi.id)) {
      _daftarFavorit.removeWhere((item) => item.id == destinasi.id);
    } else {
      _daftarFavorit.add(destinasi);
    }
    notifyListeners(); 
  }
}