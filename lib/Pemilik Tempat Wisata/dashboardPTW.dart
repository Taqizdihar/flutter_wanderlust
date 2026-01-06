import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import HTTP
import 'dart:convert';
import 'profilePTW.dart';
import 'propertyList.dart';
import 'models/dashboard_stats.dart'; // Import Model

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  DashboardStats? _stats; // Penampung data statistik
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  // --- HTTP GET REQUEST (Syarat 1: HTTP Kedua) ---
  Future<void> _fetchDashboardData() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (response.statusCode == 200) {
        setState(() {
          _stats = DashboardStats.fromJson(jsonDecode(response.body));
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching stats: $e");
    }
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PropertiesPage()));
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

  // --- WIDGET HELPER ---

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
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF26C6DA), Color(0xFF00838F)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Total Income", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Text("Rp. $income", style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStatGrid() {
    return Column(
      children: [
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
      ],
    );
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
        Text(value, style: const TextStyle(color: Color(0xFF00838F), fontSize: 32, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget _buildAvgOrderCard(String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Average Order Value", style: TextStyle(color: Color(0xFF00838F), fontSize: 16)),
        Text("Rp. $value", style: const TextStyle(color: Color(0xFF00838F), fontSize: 32, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Properties'), BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Account')],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFF00838F),
      onTap: _onItemTapped,
      backgroundColor: Colors.white,
    );
  }
}