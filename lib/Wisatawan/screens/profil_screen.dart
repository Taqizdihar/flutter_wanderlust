import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/user_model.dart';
import '../widget/menu_item_profil.dart';

import '../../login.dart';
import '../../noPage.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  final UserModel dataPengguna = const UserModel(
    nama: 'Faiz Syafiq Nabily',
    email: 'faiz@gmail.com',
    nomorTelepon: '0812-3456-7890',
    tanggalLahir: '25/10/2000',
    gender: 'Laki-laki',
    alamat: 'Peleș Castle, Sinaia, Prahova County, Romania',
    totalKunjungan: 20,
    totalPengeluaran: 5000000.00,
    asetProfil: 'assets/images/faiz.jpg',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buatHeaderProfil(context, dataPengguna),
            const SizedBox(height: 30),
            _buatRingkasanPerjalanan(dataPengguna),
            const SizedBox(height: 30),
            _buatInformasiPribadi(dataPengguna),
            const SizedBox(height: 30),
            _buatMenuAksi(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buatHeaderProfil(BuildContext context, UserModel user) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(user.asetProfil),
          backgroundColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          user.nama,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const UnderConstructionPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade400,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
            ),
            child: const Text(
              'Ubah Profil',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buatRingkasanPerjalanan(UserModel user) {
    final pemformat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ringkasan Perjalanan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.teal,
            ),
          ),
          const Divider(thickness: 2, height: 25),
          _buatRingkasanBaris(
            'Total Kunjungan',
            '${user.totalKunjungan} kunjungan',
          ),
          const SizedBox(height: 10),
          _buatRingkasanBaris(
            'Total Pengeluaran',
            pemformat.format(user.totalPengeluaran),
          ),
        ],
      ),
    );
  }

  Widget _buatRingkasanBaris(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(
            nilai,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buatInformasiPribadi(UserModel user) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informasi Pribadi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.teal,
            ),
          ),
          const Divider(thickness: 2, height: 25),
          _buatInfoBaris('Email', user.email),
          _buatInfoBaris('Nomor Telepon', user.nomorTelepon),
          _buatInfoBaris('Tanggal Lahir', user.tanggalLahir),
          _buatInfoBaris('Jenis Kelamin', user.gender),
          _buatInfoBaris('Alamat Lengkap', user.alamat, isLast: true),
        ],
      ),
    );
  }

  Widget _buatInfoBaris(String label, String nilai, {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            nilai,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          if (!isLast)
            const Divider(height: 10, color: Colors.grey, thickness: 0.5),
        ],
      ),
    );
  }

  Widget _buatMenuAksi(BuildContext context) {
    return Column(
      children: [
        MenuItemProfil(
          ikon: Icons.headphones,
          judul: 'Bantuan (Dukungan)',
          deskripsi: 'Pusat bantuan untuk pertanyaan',
          warna: Colors.teal.shade400,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => const UnderConstructionPage()),
            );
          },
        ),
        MenuItemProfil(
          ikon: Icons.people,
          judul: 'Tentang Kami',
          deskripsi: 'Ketahui lebih lanjut tentang pengembang aplikasi',
          warna: Colors.teal.shade400,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => const UnderConstructionPage()),
            );
          },
        ),
        const SizedBox(height: 20),

        // --- LOGOUT LOGIC ---
        MenuItemProfil(
          ikon: Icons.logout,
          judul: 'Keluar (Log Out)',
          deskripsi: 'Keluar dari akun Anda saat ini',
          warna: Colors.red.shade600,
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          },
        ),
        const SizedBox(height: 20),
        MenuItemProfil(
          ikon: Icons.delete_forever,
          judul: 'Hapus Akun',
          deskripsi: 'Hapus akun Anda secara permanen',
          warna: Colors.red.shade700,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => const UnderConstructionPage()),
            );
          },
          border: true,
        ),
      ],
    );
  }
}
