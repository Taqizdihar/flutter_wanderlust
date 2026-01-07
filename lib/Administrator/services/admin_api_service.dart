import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminApiService {
  // Samakan dengan IP laptop Anda
  static const String baseUrl = 'http://127.0.0.1:8000/api/flutter';

  // --- 1. Ambil Statistik Global Admin ---
  Future<Map<String, dynamic>?> getGlobalStats() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/admin/stats'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      }
    } catch (e) {
      print("Admin Stats Error: $e");
    }
    return null;
  }

  // --- 2. Ambil Daftar Verifikasi (Pemilik/Properti) ---
  Future<List<dynamic>> getPendingVerifications(String type) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/admin/pending?type=$type'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      }
    } catch (e) {
      print("Pending Error: $e");
    }
    return [];
  }
}