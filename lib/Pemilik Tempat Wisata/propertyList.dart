import 'package:flutter/material.dart';
import 'dashboardPTW.dart';
import 'profilePTW.dart';

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({super.key});

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  int _selectedIndex = 1; // Index 1 = Properties (Posisi aktif saat ini)

  void _onItemTapped(int index) {
    if (index == 0) {
      // --- LOGIKA BARU: Kembali ke Dashboard ---
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else if (index == 2) {
      // --- LOGIKA BARU: Ke Halaman Profile ---
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
    // Tidak perlu setState untuk index 1 karena kita sudah di halaman Properties
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // --- HEADER SECTION ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Properties',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00838F),
                    ),
                  ),
                  // --- UPDATE: Foto Profil Konsisten dengan Dashboard ---
                  GestureDetector(
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (c) => const ProfilePage()));
                    },
                    child: const CircleAvatar(
                      radius: 24,
                      // Pastikan nama file gambar sesuai dengan yang ada di folder assets
                      backgroundImage: AssetImage('assets/images/PTW Profile Picture.jpg'), 
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ... (Sisa kode tombol Add/Search dan List Card tetap sama) ...
              
               Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                      label: const Text(
                        "Add new property",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00838F),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              _buildPropertyCard(),
              const SizedBox(height: 16),
              _buildPropertyCard(),
              const SizedBox(height: 16),
              _buildPropertyCard(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Properties'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex, // Ini akan bernilai 1
        selectedItemColor: const Color(0xFF00838F),
        onTap: _onItemTapped, // Memanggil fungsi navigasi di atas
        backgroundColor: Colors.white,
      ),
    );
  }

  // ... (Widget _buildPropertyCard dan _buildSmallStat tetap sama)
  Widget _buildPropertyCard() {
      // Isi kode _buildPropertyCard sama seperti sebelumnya
      // ...
      return Container(
          // ...
          // Gunakan Image.network atau Image.asset sesuai kebutuhan untuk foto properti
          // ...
      );
  }
  
  Widget _buildSmallStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 14),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );
  }
}