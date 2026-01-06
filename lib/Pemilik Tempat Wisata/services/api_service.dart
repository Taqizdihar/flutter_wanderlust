import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/property_ptw.dart';
import '../models/dashboard_stats.dart';

class ApiService {
  // Gunakan IP Laptop Anda, jangan 'localhost' jika pakai Emulator
  static const String baseUrl = 'http://192.168.100.39:8000/api/flutter';

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json', // Tambahkan ini
        },
        // Gunakan jsonEncode agar data dikirim sebagai JSON murni, bukan form-data
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Login Error: $e");
    }
    return null;
  }

  // --- 1. Ambil Data Statistik Dashboard ---
  Future<DashboardStats?> getDashboardStats(int idPTW) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/stats/$idPTW'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        return DashboardStats.fromJson(decoded['data']);
      }
    } catch (e) {
      print("Error ApiService (Stats): $e");
    }
    return null;
  }

  // --- 2. Ambil Daftar Properti ---
  Future<List<PropertyPTW>> getProperties(int idPTW) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/properties/$idPTW'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((json) => PropertyPTW.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error ApiService (Properties): $e");
    }
    return [];
  }

  // --- 3. Ambil Data Profil User ---
  Future<Map<String, dynamic>?> getUserProfile(int idUser) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/profile/$idUser'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        return decoded['data'];
      }
    } catch (e) {
      print("Error ApiService (Profile): $e");
    }
    return null;
  }
}