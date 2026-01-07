import 'package:flutter/material.dart';
import 'destinasi_model.dart';
import '../services/api_service.dart'; //

class FavoritProvider extends ChangeNotifier {
  final List<Destinasi> _daftarFavorit = [];
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  List<Destinasi> get daftarFavorit => _daftarFavorit;
  bool get isLoading => _isLoading;

  // Fungsi untuk mengecek apakah sebuah destinasi ada di daftar favorit lokal
  bool apakahTersimpan(int idDestinasi) {
    return _daftarFavorit.any((item) => item.id == idDestinasi);
  }

  // --- FUNGSI BARU: Sinkronisasi awal dari Database Laravel ---
  // Fungsi ini dipanggil saat user berhasil login atau saat aplikasi baru dibuka
  Future<void> sinkronkanFavorit(int idWisatawan) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Mengambil data bookmark asli dari server
      final data = await _apiService.fetchBookmarks(idWisatawan);
      
      _daftarFavorit.clear();
      _daftarFavorit.addAll(data);
    } catch (e) {
      print("Gagal melakukan sinkronisasi favorit: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Memberitahu UI (seperti ikon bookmark) untuk memperbarui diri
    }
  }

  // Fungsi untuk update state lokal (dipanggil setelah sukses API toggle di KartuDestinasi)
  void tambahkanHapusFavorit(Destinasi destinasi) {
    if (apakahTersimpan(destinasi.id)) {
      _daftarFavorit.removeWhere((item) => item.id == destinasi.id);
    } else {
      _daftarFavorit.add(destinasi);
    }
    notifyListeners(); 
  }
}