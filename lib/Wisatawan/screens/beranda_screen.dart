import 'package:flutter/material.dart';
import '../widget/kartu_destinasi.dart';
import 'profil_screen.dart';
import 'pencarian_screen.dart';
import '../models/destinasi_model.dart';
import '../services/api_service.dart';

class BerandaScreen extends StatefulWidget {
  final int userId;
  final int idWisatawan;
  
  const BerandaScreen({
    super.key,
    required this.userId,
    required this.idWisatawan,
  });

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  late Future<List<Destinasi>> _futureDestinasi;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _futureDestinasi = _apiService.fetchDestinasi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureDestinasi = _apiService.fetchDestinasi();
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _bangunHeaderAestetik(context),
              const SizedBox(height: 10),
              _bangunJudulBagian(context, 'Destinasi Terpopuler (Live Data)'),

              FutureBuilder<List<Destinasi>>(
                future: _futureDestinasi,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 280,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return SizedBox(
                      height: 280,
                      child: Center(child: Text('Terjadi kesalahan: ${snapshot.error}')),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const SizedBox(
                      height: 280,
                      child: Center(child: Text('Data tidak tersedia')),
                    );
                  }

                  final listDestinasi = snapshot.data!;
                  return SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      itemCount: listDestinasi.length,
                      itemBuilder: (context, index) {
                        final item = listDestinasi[index];
                        return KartuDestinasi(
                          id: item.id.toString(),
                          nama: item.nama,
                          lokasi: item.lokasi,
                          rating: item.rating,
                          ulasan: item.ulasan,
                          harga: item.harga,
                          asetGambar: item.gambar,
                          deskripsi: item.deskripsi,
                          apakahListTile: false,
                          idWisatawan: widget.idWisatawan,
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bangunHeaderAestetik(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      decoration: const BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Halo, Petualang!',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Mau ke mana hari ini?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilScreen(userId: widget.userId),
                ),
              );
            },
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bangunJudulBagian(BuildContext context, String judul) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            judul,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PencarianScreen(
                    userId: widget.userId,
                    idWisatawan: widget.idWisatawan,
                  ),
                ),
              );
            },
            child: const Text('Lihat Semua', style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }
}