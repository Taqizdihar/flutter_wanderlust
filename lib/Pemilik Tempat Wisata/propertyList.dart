import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import HTTP
import 'dart:convert';
import 'dashboardPTW.dart';
import 'profilePTW.dart';
import 'models/property_ptw.dart'; // Import Model

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({super.key});

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  int _selectedIndex = 1;
  List<PropertyPTW> _properties = []; // List penampung data dari HTTP
  bool _isLoading = true; // Status loading

  @override
  void initState() {
    super.initState();
    _fetchData(); // Panggil fungsi HTTP saat halaman dibuka
  }

  // --- HTTP GET REQUEST (Syarat 1: HTTP Pertama) ---
  Future<void> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=5'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _properties = data.map((json) => PropertyPTW.fromJson(json)).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER & BUTTONS (Tetap di atas, tidak ikut scroll) ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildActionBar(),
                ],
              ),
            ),

            // --- LIST VIEW (Syarat 2: ListView.builder) ---
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      itemCount: _properties.length,
                      itemBuilder: (context, index) {
                        return _buildPropertyCard(_properties[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- REFACTORING WIDGETS UNTUK EFISIENSI ---

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('My Properties', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF00838F))),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const ProfilePage())),
          child: const CircleAvatar(radius: 24, backgroundImage: AssetImage('assets/images/PTW Profile Picture.jpg')),
        ),
      ],
    );
  }

  Widget _buildActionBar() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
            label: const Text("Add new property", style: TextStyle(color: Colors.white, fontSize: 16)),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00838F), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.grey)),
        ),
      ],
    );
  }

  Widget _buildPropertyCard(PropertyPTW property) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF26C6DA), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(property.imageUrl, width: 80, height: 80, fit: BoxFit.cover)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(property.name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    _buildStatRow(property),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildCardButtons(),
        ],
      ),
    );
  }

  Widget _buildStatRow(PropertyPTW p) {
    return Column(
      children: [
        Row(children: [_buildSmallStat(Icons.confirmation_number, "${p.tickets} tickets"), const SizedBox(width: 12), _buildSmallStat(Icons.favorite, "${p.favorites} favs")]),
        const SizedBox(height: 4),
        Row(children: [_buildSmallStat(Icons.monetization_on, "${p.sold} sold"), const SizedBox(width: 12), _buildSmallStat(Icons.touch_app, "${p.clicks} clicks")]),
      ],
    );
  }

  Widget _buildSmallStat(IconData icon, String text) {
    return Row(children: [Icon(icon, color: Colors.white, size: 12), const SizedBox(width: 4), Text(text, style: const TextStyle(color: Colors.white, fontSize: 10))]);
  }

  Widget _buildCardButtons() {
    return Row(
      children: [
        Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF006064), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text("Actions", style: TextStyle(color: Colors.white)))),
        const SizedBox(width: 16),
        Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text("View", style: TextStyle(color: Colors.white)))),
      ],
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