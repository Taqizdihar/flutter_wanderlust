import 'package:flutter/material.dart';
import 'owner_verification_page.dart';
// Pastikan path import benar sesuai struktur folder Anda
import 'models/owner_model.dart';
import 'services/admin_api_service.dart';

class PropertyOwnerListPage extends StatefulWidget {
  const PropertyOwnerListPage({super.key}); // Tambahkan const untuk performa

  @override
  State<PropertyOwnerListPage> createState() => _PropertyOwnerListPageState();
}

class _PropertyOwnerListPageState extends State<PropertyOwnerListPage> {
  final Color mainColor = const Color(0xFF0A6A84);
  
  final AdminApiService _adminApiService = AdminApiService();
  late Future<List<OwnerModel>> _futureOwners;

  @override
  void initState() {
    super.initState();
    _futureOwners = _adminApiService.getOwners();
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "aktif":
      case "active":
        return Colors.green;
      case "revisi":
      case "revision":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Property Owner List",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: mainColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureOwners = _adminApiService.getOwners();
          });
        },
        child: FutureBuilder<List<OwnerModel>>(
          future: _futureOwners,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada pemilik yang terdaftar'));
            }

            final owners = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: owners.length,
              itemBuilder: (context, index) {
                final item = owners[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(18),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(item.image), // Menggunakan data dinamis
                      onBackgroundImageError: (_, __) => const Icon(Icons.person, color: Colors.grey),
                    ),
                    title: Text(
                      item.name,
                      style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: getStatusColor(item.status),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item.status,
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // PERBAIKAN BARIS 128: Sekarang registrationDate sudah dikenali
                        Text(
                          "registered ${item.registrationDate}",
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: mainColor,
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OwnerVerificationPage(
                              ownerData: {
                                "id_user": item.idUser,
                                "name": item.name,
                                "status": item.status,
                                "image": item.image,
                                "email": item.email,
                                "phone": item.phone,
                                "organization": item.organization,
                              },
                            ),
                          ),
                        );

                        if (result != null) {
                          setState(() {
                            _futureOwners = _adminApiService.getOwners();
                          });
                        }
                      },
                      child: const Text("Actions"),
                    ),
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