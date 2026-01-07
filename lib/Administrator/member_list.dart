import 'package:flutter/material.dart';
// IMPORT MODEL DAN SERVICE BARU
import 'models/member_model.dart';
import 'services/admin_api_service.dart';

class MemberListPage extends StatefulWidget {
  const MemberListPage({super.key});

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  // INISIALISASI SERVICE DAN FUTURE
  final AdminApiService _adminApiService = AdminApiService();
  late Future<List<MemberModel>> _futureMembers;

  @override
  void initState() {
    super.initState();
    // Memanggil daftar member dari Laravel saat halaman dibuka
    _futureMembers = _adminApiService.getMembers();
  }

  // Fungsi Helper untuk memperbarui status member (Aktif/Nonaktif)
  void _toggleMemberStatus(MemberModel member) async {
    String statusBaru = member.isActive ? 'nonaktif' : 'aktif';
    bool sukses = await _adminApiService.updateUserStatus(member.idUser, statusBaru);

    if (sukses) {
      setState(() {
        _futureMembers = _adminApiService.getMembers(); // Refresh data
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${member.name} sekarang $statusBaru")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER TETAP SESUAI DESAIN IKA ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Color(0xff197B82)),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "Member List",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xff197B82)),
                      ),
                    ],
                  ),
                  Container(
                    width: 50, height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage("assets/images/profile.jpeg"), fit: BoxFit.cover),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- SEARCH & CATEGORY TETAP SESUAI DESAIN IKA ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, size: 22),
                          SizedBox(width: 10),
                          Text("Search..."),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 45,
                    decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
                    child: const Center(child: Text("Category")),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- MEMBER LIST MENGGUNAKAN FUTUREBUILDER ---
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _futureMembers = _adminApiService.getMembers();
                  });
                },
                child: FutureBuilder<List<MemberModel>>(
                  future: _futureMembers,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Tidak ada member ditemukan'));
                    }

                    final members = snapshot.data!;

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: members.length,
                      itemBuilder: (context, index) {
                        final member = members[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xffE0F3F5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member.name, // Data dinamis dari database
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff197B82)),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: member.isActive ? Colors.green.shade200 : Colors.red.shade200,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      member.isActive ? "Active Member" : "Inactive",
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "registered ${member.registrationDate}",
                                    style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black54),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _toggleMemberStatus(member),
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                                    child: Text(member.isActive ? "Set Inactive" : "Set Active"),
                                  ),
                                  const SizedBox(height: 10),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      // Logika hapus bisa ditambahkan di AdminApiService jika diperlukan
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}