import 'package:flutter/material.dart';
import 'profilePTW.dart';
import 'propertyList.dart';
import 'models/dashboard_stats.dart';
import 'services/api_service.dart'; //

class DashboardPage extends StatefulWidget {
  final int userId;
  final int ptwId;
  const DashboardPage({super.key, required this.userId, required this.ptwId});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  DashboardStats? _stats;
  bool _isLoading = true;
  final ApiService _apiService = ApiService(); // Inisialisasi Service

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // --- MENGGUNAKAN API SERVICE ---
  Future<void> _loadData() async {
    // Diasumsikan ID PTW adalah 1 (Sesuaikan dengan data di DB Laravel Anda)
    final data = await _apiService.getDashboardStats(widget.ptwId); 
    if (mounted) {
      setState(() {
        _stats = data;
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => PropertiesPage(
            userId: widget.userId, // Teruskan ID ke halaman properti
            ptwId: widget.ptwId,
          )
        )
      );
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      body: SafeArea(
        child: _isLoading 
            ? const Center(child: CircularProgressIndicator()) 
            : _stats == null 
                ? const Center(child: Text("Gagal memuat data statistik"))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 30),
                        _buildIncomeCard(_stats!.totalIncome),
                        const SizedBox(height: 24),
                        _buildStatGrid(),
                        const SizedBox(height: 24),
                        _buildAvgOrderCard(_stats!.avgOrderValue),
                      ],
                    ),
                  ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ... (Widget helper _buildHeader, _buildIncomeCard, dll tetap sama seperti sebelumnya)
  // Pastikan variabel di _buildStatGrid menggunakan data dari _stats!
  
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back,', style: TextStyle(fontSize: 16, color: Colors.grey)),
            Text('Raymond Rafiers', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF00838F))),
          ],
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const ProfilePage())),
          child: const CircleAvatar(radius: 28, backgroundImage: AssetImage('assets/images/PTW Profile Picture.jpg')),
        ),
      ],
    );
  }

  Widget _buildIncomeCard(String income) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF26C6DA), Color(0xFF00838F)]), borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Total Income", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(income, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget _buildStatGrid() {
    return Column(children: [
      Row(children: [
        Expanded(child: _buildStatCard(Icons.person, "Visitors", _stats!.totalVisitors, Colors.blue)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatCard(Icons.confirmation_number, "Sold", _stats!.ticketSold, Colors.teal)),
      ]),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: _buildStatCard(Icons.flag, "Properties", _stats!.totalProperties, Colors.green)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatCard(Icons.touch_app, "Clicks", _stats!.totalClicks, Colors.blueGrey)),
      ]),
    ]);
  }

  Widget _buildStatCard(IconData icon, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        ]),
        Text(value, style: const TextStyle(color: Color(0xFF00838F), fontSize: 28, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget _buildAvgOrderCard(String value) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Average Order Value", style: TextStyle(color: Color(0xFF00838F), fontSize: 16)),
        Text("Rp. $value", style: const TextStyle(color: Color(0xFF00838F), fontSize: 28, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Properties'), BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Account')],
      currentIndex: _selectedIndex, selectedItemColor: const Color(0xFF00838F), onTap: _onItemTapped, backgroundColor: Colors.white,
    );
  }
}