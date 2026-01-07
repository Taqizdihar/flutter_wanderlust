import 'package:flutter/material.dart';
import 'Pemilik Tempat Wisata/dashboardPTW.dart' as ptw;
import 'Administrator/dashboard.dart' as admin;
import 'Wisatawan/screens/root_screen.dart';
import 'Pemilik Tempat Wisata/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final ApiService _apiService = ApiService();

  void _handleLogin() async {
    String email = _userController.text;
    String pass = _passController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Authenticating..."),
        duration: Duration(seconds: 1),
      ),
    );

    final response = await _apiService.login(email, pass);

    if (response != null && response['success'] == true) {
      final userData = response['user'];
      final String peran = userData['peran'];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Successful"),
          backgroundColor: Colors.teal,
        ),
      );

      // Navigasi berdasarkan peran
      if (peran == 'pemilik') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            // Memanggil DashboardPage milik Pemilik menggunakan alias 'ptw'
            builder: (context) => ptw.DashboardPage(
              userId: userData['id_user'],
              ptwId: userData['id_ptw'],
            ),
          ),
        );
      } else if (peran == 'administrator') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            // Memanggil DashboardPage milik Ika menggunakan alias 'admin'
            builder: (context) => const admin.DashboardPage(),
          ),
        );
      } else if (peran == 'wisatawan') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RootScreen(
              userId: userData['id_user'],
              idWisatawan:
                  userData['id_wisatawan'], // Diambil dari respon Laravel
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email atau Password salah!"),
          backgroundColor: Colors.red,
        ),
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
              const Text(
                "Welcome back",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00838F),
                ),
              ),
              const SizedBox(height: 40),
              _buildTextField("Username / Email", _userController, false),
              const SizedBox(height: 20),
              _buildTextField("Password", _passController, true),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00838F),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget Helper buildLogo & buildTextField tetap sama ---
  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF00838F), width: 4),
      ),
      child: Image.asset(
        'assets/images/Wanderlust Logo Circle.png',
        fit: BoxFit.contain,
        errorBuilder: (c, e, s) => const Icon(
          Icons.travel_explore,
          size: 40,
          color: Color(0xFF00838F),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isPass,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF00838F),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPass,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF00838F)),
            ),
          ),
        ),
      ],
    );
  }
}
