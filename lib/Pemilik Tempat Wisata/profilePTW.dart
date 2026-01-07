import 'package:flutter/material.dart';
import '../login.dart';
import '../noPage.dart';
import 'services/api_service.dart';

class ProfilePage extends StatefulWidget {
  final int userId;
  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await _apiService.getUserProfile(widget.userId);
    if (mounted) {
      setState(() {
        _userData = data;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: _buildBackButton(context),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF00838F),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _userData == null
          ? const Center(child: Text("Gagal memuat profil"))
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      _userData!['foto_profil'] ?? 'https://i.pravatar.cc/300',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _userData!['nama'] ?? 'User',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00838F),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildEditButton(context),
                  const SizedBox(height: 30),
                  _buildPersonalInfo(),
                  const SizedBox(height: 30),
                  _buildListTile(
                    Icons.headset_mic,
                    "Support",
                    "Help centre for you",
                    const Color(0xFF26C6DA),
                    () => _navToNoPage(context),
                  ),
                  _buildListTile(
                    Icons.exit_to_app,
                    "Log Out",
                    "Log out from your account",
                    Colors.redAccent,
                    () => _showLogoutDialog(context),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
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
            width: double.infinity, padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
            child: Column(children: [
              _buildInfoRow("Email:", _userData!['email'] ?? '-'),
              const Divider(),
              _buildInfoRow("Phone:", _userData!['nomor_telepon'] ?? '-'),
              const Divider(),
              _buildInfoRow("Role:", _userData!['peran'] ?? '-'),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF00838F), width: 2),
        ),
        child: const Icon(Icons.arrow_back, color: Color(0xFF00838F), size: 18),
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Currently Unavailable"),
            backgroundColor: Color(0xFF00838F),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00838F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey[600])),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    IconData icon,
    String title,
    String sub,
    Color color,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        Divider(color: color, thickness: 2),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          leading: Icon(
            icon,
            color: title == "Log Out" ? Colors.red : const Color(0xFF00838F),
            size: 32,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: title == "Log Out" ? Colors.red : const Color(0xFF00838F),
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            sub,
            style: TextStyle(color: title == "Log Out" ? Colors.red : null),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: title == "Log Out" ? Colors.red : const Color(0xFF00838F),
          ),
          onTap: onTap,
        ),
      ],
    );
  }

  void _navToNoPage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (c) => const UnderConstructionPage()),
  );

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (c) => const LoginScreen()),
              (route) => false,
            ),
            child: const Text("Yes", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}