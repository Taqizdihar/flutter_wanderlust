import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/admin_stats_model.dart';
import '../models/member_model.dart';
import '../models/owner_model.dart';
import '../models/property_admin_model.dart';

class AdminApiService {
  // Gunakan IP Laptop Anda agar bisa diakses dari emulator/Chrome
  static const String baseUrl = 'http://127.0.0.1:8000/api/flutter';

  // --- 1. Mengambil Statistik Global Dashboard ---
  Future<AdminStats?> getGlobalStats() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/admin/stats'))
          .timeout(const Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return AdminStats.fromJson(data);
      }
    } catch (e) {
      print("Error Fetching Stats: $e");
    }
    return null;
  }

  // --- 2. Mengambil Daftar Member (Wisatawan) ---
  Future<List<MemberModel>> getMembers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/admin/members'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => MemberModel.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error Fetching Members: $e");
    }
    return [];
  }

  // --- 3. Mengambil Daftar Pemilik (PTW) ---
  Future<List<OwnerModel>> getOwners() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/admin/owners'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => OwnerModel.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error Fetching Owners: $e");
    }
    return [];
  }

  // --- 4. Mengambil Daftar Properti (Tempat Wisata) ---
  Future<List<PropertyAdminModel>> getProperties() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/admin/properties'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => PropertyAdminModel.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error Fetching Properties: $e");
    }
    return [];
  }

  // --- 5. Aksi Verifikasi: Update Status User (Member/Owner) ---
  Future<bool> updateUserStatus(int idUser, String status) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/update-user-status'),
        body: jsonEncode({'id_user': idUser, 'status': status}),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // --- 6. Aksi Verifikasi: Update Status Properti ---
  Future<bool> updatePropertyStatus(int idWisata, String status) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/update-property-status'),
        body: jsonEncode({'id_wisata': idWisata, 'status': status}),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}