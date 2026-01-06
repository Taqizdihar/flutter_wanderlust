import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/destinasi_model.dart'; // Gunakan model baru hasil modifikasi sebelumnya

class ApiService {
  // Samakan dengan alamat yang Anda gunakan di bagian Pemilik
  static const String _baseUrl = 'http://127.0.0.1:8000/api/flutter';

  // --- 1. Ambil Daftar Destinasi Wisata dari Laravel ---
  Future<List<Destinasi>> fetchDestinasi() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/wisatawan/destinasi'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((json) => Destinasi.fromJson(json)).toList();
      } else {
        print("Gagal mengambil data: ${response.statusCode}");
        return _dataFallbackWisata();
      }
    } catch (e) {
      print("Koneksi gagal: $e. Menggunakan data lokal.");
      return _dataFallbackWisata();
    }
  }

  // --- 2. Simpan Pesanan Tiket (Ke Database Laravel) ---
  Future<bool> simpanPesanan(int idWisatawan, int idTiket, int jumlah) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/wisatawan/pesan-tiket'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'id_wisatawan': idWisatawan,
              'id_tiket': idTiket,
              'jumlah_tiket': jumlah,
            }),
          )
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Gagal menyimpan pesanan: $e");
      return false;
    }
  }

  // Tambahkan di dalam class ApiService

  // --- 4. Cari Destinasi (Live Search) ---
  Future<List<Destinasi>> searchDestinasi(String query, String kategori) async {
    try {
      final response = await http
          .get(
            Uri.parse(
              '$_baseUrl/wisatawan/search?query=$query&category=$kategori',
            ),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => Destinasi.fromJson(json)).toList();
      }
    } catch (e) {
      print("Search Error: $e");
    }
    return [];
  }

  // --- 5. Ambil Daftar Bookmark (Tersimpan) ---
  Future<List<Destinasi>> fetchBookmarks(int idWisatawan) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/wisatawan/bookmarks/$idWisatawan'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => Destinasi.fromJson(json)).toList();
      }
    } catch (e) {
      print("Bookmark Error: $e");
    }
    return [];
  }

  // --- 6. Ambil Riwayat Tiket ---
  Future<List<Destinasi>> fetchUserTickets(int idWisatawan) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/wisatawan/tickets/$idWisatawan'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => Destinasi.fromJson(json)).toList();
      }
    } catch (e) {
      print("Ticket Error: $e");
    }
    return [];
  }

  Future<Map<String, dynamic>?> getUserProfile(int userId) async {
    final uri = Uri.parse('$_baseUrl/profile/$userId'); // sesuaikan endpoint
    try {
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        // Jika API membungkus data di dalam kunci 'data', ambil itu
        if (decoded is Map && decoded.containsKey('data')) {
          return Map<String, dynamic>.from(decoded['data']);
        }
        return Map<String, dynamic>.from(decoded);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // --- 3. Data Fallback (Tetap dipertahankan Faiz untuk mode offline) ---
  List<Destinasi> _dataFallbackWisata() {
    // ... (Tetap gunakan list data manual milik Faiz di sini agar aplikasi tidak crash jika server mati)
    // Pastikan mapping-nya menggunakan Destinasi.fromJson agar seragam
    return [];
  }
}
