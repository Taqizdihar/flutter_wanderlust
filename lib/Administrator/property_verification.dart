import 'package:flutter/material.dart';
import 'models/property_admin_model.dart'; //
import 'services/admin_api_service.dart'; //

class PropertyVerificationPage extends StatefulWidget {
  final PropertyAdminModel property;

  const PropertyVerificationPage({super.key, required this.property});

  @override
  State<PropertyVerificationPage> createState() => _PropertyVerificationPageState();
}

class _PropertyVerificationPageState extends State<PropertyVerificationPage> {
  final AdminApiService _adminApiService = AdminApiService();
  bool _isLoading = false;

  // Fungsi untuk memproses perubahan status (Approve/Revision)
  void _prosesVerifikasi(String status) async {
    setState(() => _isLoading = true);

    // Mengirim permintaan update ke Laravel
    bool sukses = await _adminApiService.updatePropertyStatus(
      widget.property.idWisata, 
      status
    );

    setState(() => _isLoading = false);

    if (sukses) {
      if (mounted) {
        // Kembali ke list dengan membawa pesan sukses
        Navigator.pop(context, "approved"); 
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal memperbarui status. Coba lagi.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.property;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Property Verification",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF0A6A84),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- BAGIAN FOTO DARI SERVER ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildImage(p.image), // Foto Utama
                      _buildImage(p.image), // Foto Kedua (Gunakan fallback jika di DB hanya 1 foto)
                    ],
                  ),
                  const SizedBox(height: 20),

                  _buildInfoRow("Name", p.name),
                  _buildInfoRow("Category", p.category),
                  _buildInfoRow("Status", p.status),
                  _buildInfoRow("Ticket Price", p.price),
                  _buildInfoRow("Address", p.address),
                  _buildInfoRow("Owner", p.ownerName), // Menampilkan nama pemilik dari relasi
                  
                  const SizedBox(height: 30),

                  // TOMBOL APPROVE
                  ElevatedButton(
                    onPressed: () => _prosesVerifikasi('aktif'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Approve", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),

                  const SizedBox(height: 15),

                  // TOMBOL REVISION
                  ElevatedButton(
                    onPressed: () => _prosesVerifikasi('revisi'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Revision", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  // Widget pembantu untuk menampilkan info dengan rapi
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        "$label: $value",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  // Widget pembantu untuk menampilkan gambar dari URL server
  Widget _buildImage(String url) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 50),
        ),
      ),
    );
  }
}