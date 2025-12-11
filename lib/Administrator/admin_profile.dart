import 'package:flutter/material.dart';
// Import halaman Login (mundur 2 level dari folder Administrator)
import '../login.dart'; 

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  final Color mainColor = const Color(0xFF0A6A84);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- APP BAR (Tombol Back) ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: mainColor, width: 2),
            ),
            child: Icon(Icons.arrow_back, color: mainColor, size: 18),
          ),
          onPressed: () {
            Navigator.pop(context); // Kembali ke Dashboard
          },
        ),
      ),
      
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 1), // Pendorong agar konten ada di tengah vertikal

            // --- PROFILE IMAGE ---
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: mainColor, width: 3),
              ),
              child: const CircleAvatar(
                radius: 80,
                // Pastikan gambar ini ada di folder assets Anda
                // Jika belum ada, bisa pakai Icon sementara: child: Icon(Icons.person, size: 80, color: mainColor),
                backgroundImage: AssetImage("assets/images/man 2.jpg"), 
              ),
            ),

            const SizedBox(height: 20),

            // --- TEXT ADMINISTRATOR ---
            Text(
              "Administrator",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),

            const Spacer(flex: 2), // Pendorong agar tombol logout turun ke bawah

            // --- LOGOUT BUTTON SECTION ---
            const Divider(color: Colors.red, thickness: 1.5),
            
            InkWell(
              onTap: () {
                // Navigasi Langsung ke Login (Tanpa Alert)
                // pushAndRemoveUntil menghapus riwayat halaman sebelumnya agar tidak bisa di-back
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Row(
                  children: [
                    // Ikon Keluar
                    const Icon(Icons.exit_to_app, color: Colors.red, size: 32),
                    const SizedBox(width: 16),
                    
                    // Teks Logout
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Log Out",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Log out from your account",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Panah Kanan
                    const Icon(Icons.arrow_forward_ios, color: Colors.red, size: 20),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 10), // Jarak aman bawah
          ],
        ),
      ),
    );
  }
}