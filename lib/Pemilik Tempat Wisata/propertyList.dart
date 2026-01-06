import 'package:flutter/material.dart';
import 'dashboardPTW.dart';
import 'profilePTW.dart';
import 'models/property_ptw.dart';
import 'services/api_service.dart'; //

class PropertiesPage extends StatefulWidget {
  final int userId; // Tambahkan parameter
  final int ptwId;
  const PropertiesPage({super.key, required this.userId, required this.ptwId});

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  int _selectedIndex = 1;
  List<PropertyPTW> _properties = [];
  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    // Diasumsikan ID PTW adalah 1
    final data = await _apiService.getProperties(widget.ptwId); 
    if (mounted) {
      setState(() {
        _properties = data;
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => DashboardPage(userId: widget.userId, ptwId: widget.ptwId)
        )
      );
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userId: widget.userId)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      body: SafeArea(
        child: Column(
          children: [
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
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _properties.isEmpty
                      ? const Center(child: Text("Anda belum memiliki properti"))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          itemCount: _properties.length,
                          itemBuilder: (context, index) => _buildPropertyCard(_properties[index]),
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ... (Widget helper _buildHeader, _buildActionBar, _buildPropertyCard tetap sama)
  // Pastikan _buildPropertyCard menggunakan field dari model PropertyPTW yang baru
  
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('My Properties', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF00838F))),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ProfilePage(userId: widget.userId))),
          child: const CircleAvatar(radius: 24, backgroundImage: AssetImage('assets/images/PTW Profile Picture.jpg')),
        ),
      ],
    );
  }

  Widget _buildActionBar() {
    return Row(children: [
      Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add_circle_outline, color: Colors.white), label: const Text("Add new property", style: TextStyle(color: Colors.white, fontSize: 16)), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00838F), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))))),
      const SizedBox(width: 12),
      Container(decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.grey))),
    ]);
  }

  Widget _buildPropertyCard(PropertyPTW property) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF26C6DA), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))]),
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(property.imageUrl, width: 80, height: 80, fit: BoxFit.cover)),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(property.name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
            Text(property.location, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 8),
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(4)), child: Text(property.status, style: const TextStyle(color: Colors.white, fontSize: 10))),
          ])),
        ]),
        const SizedBox(height: 12),
        _buildCardButtons(),
      ]),
    );
  }

  Widget _buildCardButtons() {
    return Row(children: [
      Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF006064), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text("Actions", style: TextStyle(color: Colors.white)))),
      const SizedBox(width: 16),
      Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text("View", style: TextStyle(color: Colors.white)))),
    ]);
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Properties'), BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Account')],
      currentIndex: _selectedIndex, selectedItemColor: const Color(0xFF00838F), onTap: _onItemTapped, backgroundColor: Colors.white,
    );
  }
}