import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'property_list.dart';
import 'member_list.dart';
import 'property_owner_list.dart';
import 'admin_profile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final Color primaryColor = const Color(0xFF0A6A84);
  final Color accentColor = const Color(0xFF1493B1);

  Future<String> fetchTotalMembers() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.length.toString();
    }
    return "0";
  }

  Future<String> fetchTotalProperties() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return (data.length % 40).toString();
    }
    return "0";
  }

  Future<String> fetchTotalOwners() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    );
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return (data.length % 70).toString();
    }
    return "0";
  }

  // =======================================================
  // --- KETENTUAN 3 & 4: SNACKBAR & TOAST ---
  // =======================================================
  void _showSnackbar(
    BuildContext context,
    String message, {
    bool isToast = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: isToast ? TextAlign.center : TextAlign.start,
        ),
        backgroundColor: isToast ? Colors.black87 : primaryColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        margin: isToast
            ? const EdgeInsets.symmetric(horizontal: 80, vertical: 20)
            : const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  // =======================================================
  // --- KETENTUAN 2: BOTTOM SHEET & DIALOG ---
  // =======================================================
  void _showRevenueDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(25),
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Revenue Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.trending_up, color: Colors.green),
                title: Text("This Month"),
                trailing: Text("Rp. 1.200.000"),
              ),
              const ListTile(
                leading: Icon(Icons.history, color: Colors.orange),
                title: Text("Last Month"),
                trailing: Text("Rp. 1.800.000"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      bottomNavigationBar: _buildBottomNav(context),
      body: Stack(
        children: [
          _buildHeaderBackground(context),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildUserInfo(
                      context,
                    ), // <--- Sekarang butuh context buat navigasi
                    const SizedBox(height: 30),

                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.1,
                      children: [
                        _buildStatCardHTTP(
                          context,
                          icon: Icons.people_alt_rounded,
                          title: "Total Members",
                          future: fetchTotalMembers(),
                          onTap: () {
                            _showSnackbar(
                              context,
                              "Membuka List Member...",
                              isToast: true,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MemberListPage(),
                              ),
                            );
                          },
                        ),
                        _buildStatCardHTTP(
                          context,
                          icon: Icons.location_city_rounded,
                          title: "Total Properties",
                          future: fetchTotalProperties(),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PropertyListPage(),
                            ),
                          ),
                        ),
                        _buildStatCardHTTP(
                          context,
                          icon: Icons.supervised_user_circle_rounded,
                          title: "Owner List",
                          future: fetchTotalOwners(),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PropertyOwnerListPage(),
                            ),
                          ),
                        ),
                        _buildStatCardStatic(
                          context,
                          icon: Icons.account_balance_wallet_rounded,
                          title: "Total Top Up",
                          value: "32",
                          onTap: () => _showSnackbar(
                            context,
                            "Fitur Top Up Belum Tersedia",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),
                    _buildWideCard(
                      icon: Icons.payments_rounded,
                      title: "Accumulated Revenues",
                      value: "Rp. 3.000.000",
                      color: Colors.green.shade600,
                      onTap: () => _showRevenueDetails(context),
                    ),
                    const SizedBox(height: 15),
                    _buildWideCard(
                      icon: Icons.analytics_rounded,
                      title: "Avg. Revenue / Trans",
                      value: "Rp. 150.000",
                      color: primaryColor,
                      onTap: () {},
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Header User Info (Avatar sekarang bisa diklik ke Profil) ---
  Widget _buildUserInfo(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome,", style: TextStyle(color: Colors.white70)),
          Text(
            "Riska Dea Bakri",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AdminProfilePage()),
        ),
        child: const CircleAvatar(
          radius: 28,
          // Hapus satu kata "assets/", jadi seperti ini:
          backgroundImage: AssetImage("assets/images/profile.jpeg"),
        ),
      ),
    ],
  );

  // --- Bottom Navigation (Menu Profile sekarang berfungsi) ---
  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      onTap: (index) {
        if (index == 1) {
          // <--- Tambahan pindah ke Halaman Profil
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AdminProfilePage()),
          );
        } else if (index == 2) {
          _showLogoutDialog(context);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_rounded),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ), // <--- Terhubung ke AdminProfilePage
        BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
      ],
    );
  }

  // --- Widget Card & UI lainnya (Tetap seperti aslinya) ---
  Widget _buildStatCardHTTP(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Future<String> future,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: primaryColor),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String>(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }
                      return Text(
                        snapshot.data ?? "0",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCardStatic(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: primaryColor),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWideCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBackground(BuildContext context) => Container(
    height: 250,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [accentColor, primaryColor]),
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
    ),
  );
}
