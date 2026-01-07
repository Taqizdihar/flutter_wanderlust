import 'package:flutter/material.dart';
import '../widget/kartu_destinasi.dart';
import '../services/api_service.dart';
import '../models/destinasi_model.dart';

class PencarianScreen extends StatefulWidget {
  final int userId;
  final int idWisatawan;

  const PencarianScreen({
    super.key,
    required this.userId,
    required this.idWisatawan,
  });

  @override
  State<PencarianScreen> createState() => _PencarianScreenState();
}

class _PencarianScreenState extends State<PencarianScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _kategoriAktif = 'Semua';
  List<Destinasi> _hasilPencarian = []; 
  bool _isSearching = false;
  final ApiService _apiService = ApiService();

  void _performSearch(String query) async {
    if (query.isEmpty && _kategoriAktif == 'Semua') {
      setState(() => _hasilPencarian = []);
      return;
    }

    setState(() => _isSearching = true);

    final hasil = await _apiService.searchDestinasi(query, _kategoriAktif);
    
    setState(() {
      _hasilPencarian = hasil;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Cari destinasi...',
            border: InputBorder.none,
          ),
          onChanged: (value) => _performSearch(value),
        ),
      ),
      body: Column(
        children: [
          _bangunFilterKategori(),
          const Divider(height: 1),
          Expanded(
            child: _isSearching
                ? const Center(child: CircularProgressIndicator())
                : _hasilPencarian.isEmpty
                    ? _bangunHasilKosong()
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _hasilPencarian.length,
                        itemBuilder: (context, index) {
                          final dest = _hasilPencarian[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: KartuDestinasi(
                              id: dest.id.toString(),
                              nama: dest.nama,
                              lokasi: dest.lokasi,
                              rating: dest.rating,
                              ulasan: dest.ulasan,
                              harga: dest.harga,
                              asetGambar: dest.gambar,
                              deskripsi: dest.deskripsi,
                              apakahListTile: true,
                              idWisatawan: widget.idWisatawan,
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _bangunFilterKategori() {
    final kategori = ['Semua', 'Pantai', 'Gunung', 'Budaya', 'Edukasi'];
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: kategori.length,
        itemBuilder: (context, index) {
          final item = kategori[index];
          final bool isActive = _kategoriAktif == item;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ChoiceChip(
              label: Text(item),
              selected: isActive,
              selectedColor: Colors.teal,
              labelStyle: TextStyle(color: isActive ? Colors.white : Colors.black87),
              onSelected: (bool selected) {
                setState(() => _kategoriAktif = item);
                _performSearch(_searchController.text);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _bangunHasilKosong() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isEmpty 
              ? 'Mulai cari destinasi impianmu' 
              : 'Destinasi tidak ditemukan',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}