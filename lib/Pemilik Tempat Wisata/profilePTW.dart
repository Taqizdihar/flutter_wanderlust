import 'package:flutter/material.dart';
import '../login.dart';
import '../noPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: _buildBackButton(context),
        title: const Text('Profile', style: TextStyle(color: Color(0xFF00838F), fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // --- HTTP REQUEST (Syarat 1: HTTP Ketiga via NetworkImage) ---
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=11'), // Mengambil gambar dari internet
            ),
            const SizedBox(height: 16),
            const Text('Raymond Rafiers', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF00838F))),
            const SizedBox(height: 10),
            _buildEditButton(context),
            const SizedBox(height: 30),
            _buildPersonalInfo(),
            const SizedBox(height: 30),
            _buildListTile(Icons.headset_mic, "Support", "Help centre for you", const Color(0xFF26C6DA), () => _navToNoPage(context)),
            _buildListTile(Icons.exit_to_app, "Log Out", "Log out from your account", Colors.redAccent, () => _showLogoutDialog(context)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPERS (MINIMAL & EFISIEN) ---

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF00838F), width: 2)),
        child: const Icon(Icons.arrow_back, color: Color(0xFF00838F), size: 18),
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _navToNoPage(context),
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00838F), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
      child: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildPersonalInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Personal Information", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00838F))),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                _buildInfoRow("Email:", "raymond@gmail.com"),
                const Divider(),
                _buildInfoRow("Phone:", "0813-1313-3131"),
                const Divider(),
                _buildInfoRow("Address:", "Jl. Kemakmuran Jaya No. 45, Bandung."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [SizedBox(width: 80, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))), Expanded(child: Text(value, style: TextStyle(color: Colors.grey[600])))]),
    );
  }

  Widget _buildListTile(IconData icon, String title, String sub, Color color, VoidCallback onTap) {
    return Column(
      children: [
        Divider(color: color, thickness: 2),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          leading: Icon(icon, color: title == "Log Out" ? Colors.red : const Color(0xFF00838F), size: 32),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: title == "Log Out" ? Colors.red : const Color(0xFF00838F), fontSize: 18)),
          subtitle: Text(sub, style: TextStyle(color: title == "Log Out" ? Colors.red : null)),
          trailing: Icon(Icons.arrow_forward_ios, color: title == "Log Out" ? Colors.red : const Color(0xFF00838F)),
          onTap: onTap,
        ),
      ],
    );
  }

  void _navToNoPage(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (c) => const UnderConstructionPage()));

  // --- SYARAT 3: DIALOG ---
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("No")),
          TextButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const LoginScreen())), child: const Text("Yes", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
} 