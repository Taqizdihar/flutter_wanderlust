// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import '../models/user_model.dart'; 
import '../services/api_service.dart'; 
import '../../login.dart'; 

class ProfilScreen extends StatefulWidget {
  final int userId;
  const ProfilScreen({super.key, required this.userId});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  late Future<UserModel?> _futureUser;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // PERBAIKAN: Menambahkan operator '!' untuk memastikan data tidak null setelah dicek
    _futureUser = _apiService.getUserProfile(widget.userId).then((data) {
      return data != null ? UserModel.fromJson(data) : null;
    });
  }

  void _handleLogout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Berhasil Logout"), backgroundColor: Colors.teal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50, 
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<UserModel?>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Menampilkan pesan error jika data null atau gagal dimuat
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Gagal memuat profil. Pastikan server menyala."));
          }

          final user = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _futureUser = _apiService.getUserProfile(widget.userId).then((data) {
                  return data != null ? UserModel.fromJson(data) : null;
                });
              });
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  _buatHeaderProfil(user),
                  const SizedBox(height: 30),
                  _buatRingkasanPerjalanan(user),
                  const SizedBox(height: 20),
                  _buatInformasiPribadi(user),
                  const SizedBox(height: 40),
                  _buatMenuAksi(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buatHeaderProfil(UserModel user) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.teal.shade100,
          // PERBAIKAN: Menggunakan null-check '?' agar tidak error saat fotoProfil null
          backgroundImage: (user.fotoProfil != null && user.fotoProfil.isNotEmpty) 
              ? NetworkImage(user.fotoProfil) 
              : null,
          child: (user.fotoProfil == null || user.fotoProfil.isEmpty) 
              ? const Icon(Icons.person, size: 60, color: Colors.teal) 
              : null,
        ),
        const SizedBox(height: 16),
        Text(user.nama, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal)),
        Text(user.email, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buatRingkasanPerjalanan(UserModel user) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _itemRingkasan("10", "Perjalanan"),
          _itemRingkasan("5", "Favorit"),
          _itemRingkasan("12", "Ulasan"),
        ],
      ),
    );
  }

  Widget _itemRingkasan(String angka, String label) {
    return Column(
      children: [
        Text(angka, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buatInformasiPribadi(UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Informasi Pribadi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
        const SizedBox(height: 12),
        _tileInfo(Icons.phone, 'Telepon', user.nomorTelepon),
        _tileInfo(Icons.location_on, 'Alamat', user.alamat),
        _tileInfo(Icons.location_city, 'Kota Asal', user.kotaAsal),
      ],
    );
  }

  Widget _tileInfo(IconData ikon, String label, String isi) {
    return ListTile(
      leading: Icon(ikon, color: Colors.teal),
      title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(isi != null && isi.isNotEmpty ? isi : '-', style: const TextStyle(fontSize: 16, color: Colors.black87)),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buatMenuAksi() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {}, 
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('Edit Profil', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _handleLogout,
            style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('Keluar Akun', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}