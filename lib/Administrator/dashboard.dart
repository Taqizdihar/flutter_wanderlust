// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'property_list.dart';
import 'member_list.dart';
import 'property_owner_list.dart';
import 'admin_profile.dart';
// IMPORT SERVICE DAN MODEL BARU
import 'services/admin_api_service.dart';
import 'models/admin_stats_model.dart';
import '../login.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final Color primaryColor = const Color(0xFF0A6A84);
  final Color accentColor = const Color(0xFF1493B1);

  // INISIALISASI SERVICE
  final AdminApiService _adminApiService = AdminApiService();
  late Future<AdminStats?> _statsFuture;

  @override
  void initState() {
    super.initState();
    // Memanggil data statistik global dari Laravel saat halaman dimuat
    _statsFuture = _adminApiService.getGlobalStats();
  }

  // --- REVENUE DETAILS & LOGOUT DIALOG TETAP SAMA ---
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
          child: const Text("Cancel")
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            // PERBAIKAN: Navigasi reset ke LoginScreen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          },
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
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _statsFuture = _adminApiService.getGlobalStats();
                });
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildUserInfo(context),
                      const SizedBox(height: 30),

                      // FUTUREBUILDER UNTUK MENGISI DATA STATISTIK SECARA DINAMIS
                      FutureBuilder<AdminStats?>(
                        future: _statsFuture,
                        builder: (context, snapshot) {
                          final stats = snapshot.data;

                          return GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.1,
                            children: [
                              _buildStatCard(
                                icon: Icons.people_alt_rounded,
                                title: "Total Members",
                                value: stats?.totalMembers ?? "...",
                                isLoading:
                                    snapshot.connectionState ==
                                    ConnectionState.waiting,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const MemberListPage(),
                                  ),
                                ),
                              ),
                              _buildStatCard(
                                icon: Icons.location_city_rounded,
                                title: "Total Properties",
                                value: stats?.totalProperties ?? "...",
                                isLoading:
                                    snapshot.connectionState ==
                                    ConnectionState.waiting,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PropertyListPage(),
                                  ),
                                ),
                              ),
                              _buildStatCard(
                                icon: Icons.supervised_user_circle_rounded,
                                title: "Owner List",
                                value: stats?.totalOwners ?? "...",
                                isLoading:
                                    snapshot.connectionState ==
                                    ConnectionState.waiting,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PropertyOwnerListPage(),
                                  ),
                                ),
                              ),
                              _buildStatCard(
                                icon: Icons.account_balance_wallet_rounded,
                                title: "Total Top Up",
                                value: "32", // Data statis sementara
                                onTap: () {},
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 25),
                      // MENGGUNAKAN DATA REVENUE DARI LARAVEL
                      FutureBuilder<AdminStats?>(
                        future: _statsFuture,
                        builder: (context, snapshot) {
                          return _buildWideCard(
                            icon: Icons.payments_rounded,
                            title: "Accumulated Revenues",
                            value: snapshot.data?.totalRevenue ?? "Rp. 0",
                            color: Colors.green.shade600,
                            onTap: () => _showRevenueDetails(context),
                          );
                        },
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
          ),
        ],
      ),
    );
  }

  // --- HELPER WIDGET UNTUK KARTU STATISTIK (Disederhanakan agar UI tetap sama) ---
  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    bool isLoading = false,
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
                  isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
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

  Widget _buildUserInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Halo, Admin!",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              "Selamat Datang Kembali",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
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
            radius: 25,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      currentIndex: 0, // Dashboard aktif
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Alerts',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      onTap: (index) {
        if (index == 2) _showLogoutDialog(context);
      },
    );
  }

  Widget _buildWideCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  Widget _buildHeaderBackground(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [accentColor, primaryColor]),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    );
  }
}
