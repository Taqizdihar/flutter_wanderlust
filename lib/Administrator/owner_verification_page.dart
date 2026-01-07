import 'package:flutter/material.dart';
import 'services/admin_api_service.dart';

class OwnerVerificationPage extends StatefulWidget {
  final Map<String, dynamic> ownerData;

  const OwnerVerificationPage({super.key, required this.ownerData});

  @override
  State<OwnerVerificationPage> createState() => _OwnerVerificationPageState();
}

class _OwnerVerificationPageState extends State<OwnerVerificationPage> {
  final Color mainColor = const Color(0xFF0A6A84);
  final AdminApiService _adminApiService = AdminApiService();
  String currentStatus = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.ownerData["status"];
  }

  void _prosesVerifikasi(String status) async {
    setState(() => _isLoading = true);

    bool sukses = await _adminApiService.updateUserStatus(
      widget.ownerData["id_user"],
      status,
    );

    setState(() => _isLoading = false);

    if (sukses) {
      if (mounted) {
        Navigator.pop(context, status);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal memperbarui status pemilik.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.ownerData;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context, currentStatus),
        ),
        title: Text(
          "Owner Identity Verification",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(data["image"]),
                    onBackgroundImageError: (_, __) =>
                        const Icon(Icons.person, size: 60),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    data["name"],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  buildDetail("Full Name", data["name"]),
                  buildDetail("Email", data["email"]),
                  buildDetail("Phone Number", data["phone"]),
                  buildDetail(
                    "Organization",
                    data["organization"],
                  ),

                  const SizedBox(height: 20),
                  buildDocumentButton("See Tax Document"),
                  const SizedBox(height: 12),
                  buildDocumentButton("See Legal Business Document"),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () => _prosesVerifikasi('aktif'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Approve",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 14),

                  ElevatedButton(
                    onPressed: () => _prosesVerifikasi('revisi'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Revision",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$title:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : "-",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDocumentButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const Icon(Icons.open_in_new, color: Colors.white),
        ],
      ),
    );
  }
}
