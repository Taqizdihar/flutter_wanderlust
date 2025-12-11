import 'package:flutter/material.dart';
import '../widget/kartu_destinasi.dart';

class PencarianScreen extends StatefulWidget {
  const PencarianScreen({super.key});

  @override
  State<PencarianScreen> createState() => _PencarianScreenState();
}

class _PencarianScreenState extends State<PencarianScreen> {
  String _query = '';
  String _kategoriAktif = 'Semua';
  final TextEditingController _controller = TextEditingController();

  final List<String> _kategori = [
    'Semua',
    'Alam',
    'Budaya',
    'Edukasi',
    'Hiburan',
  ];

  final List<Map<String, dynamic>> _semuaDestinasi = [
    {
      'nama': 'Kebun Binatang Bandung',
      'lokasi': 'Bandung, Jawa Barat',
      'jenis': 'Edukasi',
      'rating': 4.3,
      'ulasan': 321,
      'harga': 50000,
      'asetGambar': 'assets/images/bandung_zoo.jpg',
    },
    {
      'nama': 'Tur Lava Merapi',
      'lokasi': 'Sleman, Daerah Istimewa Yogyakarta',
      'jenis': 'Alam',
      'rating': 4.6,
      'ulasan': 154,
      'harga': 350000,
      'asetGambar': 'assets/images/lava_merapi.jpg',
    },
    {
      'nama': 'The Great Asia Africa',
      'lokasi': 'Bandung, Jawa Barat',
      'jenis': 'Edukasi',
      'rating': 4.0,
      'ulasan': 311,
      'harga': 44000,
      'asetGambar': 'assets/images/The_Great_Asia_Africa.jpg',
    },
    {
      'nama': 'Gunung Bromo',
      'lokasi': 'Probolinggo, Jawa Timur',
      'jenis': 'Alam',
      'rating': 4.5,
      'ulasan': 981,
      'harga': 125000,
      'asetGambar': 'assets/images/mount_bromo.jpg',
    },
    {
      'nama': 'Candi Borobudur',
      'lokasi': 'Magelang, Jawa Tengah',
      'jenis': 'Budaya',
      'rating': 4.8,
      'ulasan': 571,
      'harga': 50000,
      'asetGambar': 'assets/images/borobudur.jpg',
    },
    {
      'nama': "D'Castello Wisata Flora",
      'lokasi': 'Subang, Jawa Barat',
      'jenis': 'Alam',
      'rating': 4.6,
      'ulasan': 229,
      'harga': 30000,
      'asetGambar': 'assets/images/DCastello.jpg',
    },
    {
      'nama': 'Trans Studio Bandung',
      'lokasi': 'Bandung, Jawa Barat',
      'jenis': 'Hiburan',
      'rating': 4.5,
      'ulasan': 288,
      'harga': 200000,
      'asetGambar': 'assets/images/trans_studio.jpg',
    },
    {
      'nama': 'Museum Nasional Indonesia',
      'lokasi': 'Jakarta Pusat, Jakarta',
      'jenis': 'Budaya',
      'rating': 4.4,
      'ulasan': 305,
      'harga': 25000,
      'asetGambar': 'assets/images/national_museum.jpg',
    },
  ];

  List<Map<String, dynamic>> _filterDestinasi() {
    return _semuaDestinasi.where((dest) {
      final queryLower = _query.toLowerCase();
      final namaLower = dest['nama'].toLowerCase();
      final lokasiLower = dest['lokasi'].toLowerCase();
      final jenis = dest['jenis'];

      final matchesQuery =
          namaLower.contains(queryLower) || lokasiLower.contains(queryLower);

      final matchesCategory =
          _kategoriAktif == 'Semua' || jenis == _kategoriAktif;

      return matchesQuery && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasilFilter = _filterDestinasi();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: _bangunKolomPencarian(context),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bangunFilterKategori(),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 15.0, bottom: 10.0),
            child: Text(
              'Hasil Pencarian (${hasilFilter.length})',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          Expanded(
            child: hasilFilter.isEmpty
                ? _bangunHasilKosong()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: hasilFilter.length,
                    itemBuilder: (context, index) {
                      final dest = hasilFilter[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: KartuDestinasi(
                          nama: dest['nama'],
                          lokasi: dest['lokasi'],
                          rating: dest['rating'],
                          ulasan: dest['ulasan'],
                          harga: dest['harga'],
                          asetGambar: dest['asetGambar'],
                          apakahListTile: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _bangunKolomPencarian(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: TextField(
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Cari nama destinasi, kota, atau kategori...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
                onSubmitted: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bangunFilterKategori() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          itemCount: _kategori.length,
          itemBuilder: (context, index) {
            final kategori = _kategori[index];
            final isActive = kategori == _kategoriAktif;

            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ChoiceChip(
                label: Text(kategori),
                selected: isActive,
                selectedColor: Colors.teal.shade200,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: isActive ? Colors.black87 : Colors.grey,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
                onSelected: (selected) {
                  setState(() {
                    _kategoriAktif = selected ? kategori : 'Semua';
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _bangunHasilKosong() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_off, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 10),
          const Text(
            'Destinasi tidak ditemukan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Coba periksa kata kunci atau ubah kategori pencarian.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
