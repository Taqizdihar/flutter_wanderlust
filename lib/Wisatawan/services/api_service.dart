import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/destinasi_model.dart';

class ApiService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api/flutter';

  Future<Map<String, dynamic>?> getUserProfile(int userId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl/profile/$userId'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map && decoded.containsKey('data')) {
          return Map<String, dynamic>.from(decoded['data']);
        }
        return Map<String, dynamic>.from(decoded);
      }
    } catch (e) {
      print("Profile Error: $e");
    }
    return null;
  }

  Future<List<Destinasi>> fetchDestinasi() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/wisatawan/destinasi'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((json) => Destinasi.fromJson(json)).toList();
      }
    } catch (e) {
      print("Koneksi gagal: $e.");
    }
    return [];
  }

  Future<bool> toggleBookmark(int idWisatawan, int idWisata) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/wisatawan/bookmarks/toggle'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'id_wisatawan': idWisatawan,
              'id_wisata': idWisata,
            }),
          )
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Bookmark Toggle Error: $e");
      return false;
    }
  }

  Future<bool> simpanPesanan(int idWisatawan, int idWisata, int jumlah) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/wisatawan/pesan-tiket'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'id_wisatawan': idWisatawan,
              'id_wisata': idWisata,
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

  Future<List<Destinasi>> fetchBookmarks(int idWisatawan) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/wisatawan/bookmarks/$idWisatawan'))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => Destinasi.fromJson(json)).toList();
      }
    } catch (e) {
      print("Bookmark Fetch Error: $e");
    }
    return [];
  }

  Future<List<Destinasi>> fetchUserTickets(int idWisatawan) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/wisatawan/tickets/$idWisatawan'))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => Destinasi.fromJson(json)).toList();
      }
    } catch (e) {
      print("Ticket Fetch Error: $e");
    }
    return [];
  }
}
