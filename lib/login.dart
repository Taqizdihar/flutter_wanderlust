import 'package:flutter/material.dart';
import 'Pemilik Tempat Wisata/dashboardPTW.dart';
import 'Administrator/dashboard.dart';
import 'Wisatawan/screens/root_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _handleLogin() {
    String user = _userController.text;
    String pass = _passController.text;

    Widget? targetPage;

    if (user == 'alnilambda' && pass == '123') {
      targetPage = const DashboardPage();
    } else if (user == 'riska' && pass == '123') {
      targetPage = const AdminDashboardPage();
    } else if (user == 'faiz' && pass == '123') {
      targetPage = const RootScreen();
    }

    if (targetPage != null) {
      // --- SYARAT 4: SNACKBAR (Login Successful) ---
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful"), backgroundColor: Colors.teal, duration: Duration(seconds: 2)),
      );
      
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => targetPage!));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username atau Password salah!"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              _buildLogo(),
              const SizedBox(height: 24),
              const Text("Welcome back", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF00838F))),
              const SizedBox(height: 40),
              _buildTextField("Username / Email", _userController, false),
              const SizedBox(height: 20),
              _buildTextField("Password", _passController, true),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00838F), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text("Log In", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 120, height: 120, padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF00838F), width: 4)),
      child: Image.asset('assets/images/Wanderlust Logo Circle.png', fit: BoxFit.contain, errorBuilder: (c, e, s) => const Icon(Icons.travel_explore, size: 40, color: Color(0xFF00838F))),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, bool isPass) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00838F), fontSize: 16)),
        const SizedBox(height: 8),
        TextField(controller: controller, obscureText: isPass, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF00838F))))),
      ],
    );
  }
}