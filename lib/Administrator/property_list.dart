import 'package:flutter/material.dart';
import 'property_verification.dart';
// IMPORT MODEL DAN SERVICE BARU
import 'models/property_admin_model.dart';
import 'services/admin_api_service.dart';

class PropertyListPage extends StatefulWidget {
  const PropertyListPage({super.key});

  @override
  State<PropertyListPage> createState() => _PropertyListPageState();
}

class _PropertyListPageState extends State<PropertyListPage> {
  // INISIALISASI SERVICE DAN FUTURE
  final AdminApiService _adminApiService = AdminApiService();
  late Future<List<PropertyAdminModel>> _futureProperties;

  @override
  void initState() {
    super.initState();
    // Mengambil daftar properti dari Laravel saat inisialisasi
    _futureProperties = _adminApiService.getProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0A6A84)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Property List",
          style: TextStyle(
            fontSize: 24, 
            color: Color(0xFF0A6A84), 
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureProperties = _adminApiService.getProperties();
          });
        },
        child: FutureBuilder<List<PropertyAdminModel>>(
          future: _futureProperties,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada properti yang perlu diverifikasi'));
            }

            final properties = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final p = properties[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5FB1CC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.name, // Menggunakan data dari model dinamis
                              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Status: ${p.status}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              "Owner: ${p.ownerName}",
                              style: const TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF0A6A84),
                        ),
                        onPressed: () async {
                          // PERBAIKAN BARIS 112: Kirim seluruh objek properti 'p' 
                          // agar sinkron dengan konstruktor PropertyVerificationPage
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PropertyVerificationPage(
                                property: p, 
                              ),
                            ),
                          );

                          // Jika kembali dengan status 'approved', refresh list dari database
                          if (result == "approved") {
                            setState(() {
                              _futureProperties = _adminApiService.getProperties(); 
                            });

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Status Properti Berhasil Diperbarui"),
                                  backgroundColor: Colors.teal,
                                ),
                              );
                            }
                          }
                        },
                        child: const Text("Actions"),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}