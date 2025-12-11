import 'package:flutter/material.dart';

// 1. Import Dashboard Pemilik Tempat Wisata
import 'Pemilik Tempat Wisata/dashboardPTW.dart';

// 2. Import Dashboard Administrator
import 'Administrator/dashboard.dart';

// 3. Import Wisatawan (Arahkan ke ROOT SCREEN agar Bottom Nav Bar muncul)
import 'Wisatawan/screens/root_screen.dart'; 

// Import Halaman Under Construction
// ignore: unused_import
import 'noPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // --- LOGIKA LOGIN ---

    // 1. PEMILIK TEMPAT WISATA
    if (username == 'alnilambda' && password == '123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } 
    // 2. ADMINISTRATOR
    else if (username == 'riska' && password == '123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminDashboardPage()),
      );
    } 
    // 3. WISATAWAN (Update path ke RootScreen)
    else if (username == 'faiz' && password == '123') {
      Navigator.pushReplacement(
        context,
        // Masuk ke RootScreen agar navigasi bawah (Beranda, Tiket, dll) muncul
        MaterialPageRoute(builder: (context) => const RootScreen()), 
      );
    } 
    // GAGAL
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Username atau Password salah!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... (Sisa kode tampilan Login SAMA PERSIS seperti sebelumnya, tidak perlu diubah)
    // Cukup copy-paste bagian build() dari file login.dart Anda yang terakhir.
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Logo
              Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF00838F), width: 4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/Wanderlust Logo Circle.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.travel_explore, size: 40, color: Color(0xFF00838F)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text("Welcome back", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF00838F))),
              const SizedBox(height: 40),
              
              // Input Fields (Username & Password) - Sama seperti kode Anda sebelumnya
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Username / Email", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00838F), fontSize: 16)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF00838F))),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Password", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00838F), fontSize: 16)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF00838F))),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00838F),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Log In", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}