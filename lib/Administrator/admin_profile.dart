import 'package:flutter/material.dart';
import 'edit_profile.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  final Color primaryColor = const Color(0xFF0A6A84);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Profile"),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // --- PINDAH KE HALAMAN EDIT (Gacor Beb!) ---
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian Header Profile
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 46,
                    backgroundImage: AssetImage("assets/images/profile.jpeg"),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Detail Informasi (Tampilan tetap cantik seperti permintaanmu)
            _profileItem(Icons.person, "Nama Lengkap", "Riska Dea Bakri"),
            _profileItem(Icons.email, "Email", "riska.dea@admin.com"),
            _profileItem(
              Icons.location_on,
              "Alamat",
              "Jl. Properti No. 123, Bandung",
            ),
            _profileItem(
              Icons.description,
              "Deskripsi",
              "Head Administrator untuk Manajemen Properti wilayah Jawa Barat.",
            ),
            _profileItem(Icons.phone, "Nomor Telepon", "+62 812-3456-7890"),
          ],
        ),
      ),
    );
  }

  Widget _profileItem(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(
        label,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
