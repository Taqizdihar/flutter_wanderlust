import 'package:flutter/material.dart';

class Member {
  String name;
  bool isActive;
  String date;

  Member({
    required this.name,
    required this.isActive,
    required this.date,
  });
}

class MemberListPage extends StatefulWidget {
  const MemberListPage({super.key});

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  List<Member> members = [
    Member(name: "Michael", isActive: true, date: "28/4/2025"),
    Member(name: "Sarah", isActive: false, date: "28/4/2025"),
    Member(name: "Jonathan", isActive: true, date: "28/4/2025"),
    Member(name: "Anna", isActive: true, date: "28/4/2025"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          children: [
            // Header + Back Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context); // Kembali ke dashboard
                        },
                        icon: const Icon(Icons.arrow_back,
                            color: Color(0xff197B82)),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "Member List",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff197B82),
                        ),
                      ),
                    ],
                  ),
                  // Icon Profil Kecil
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xff197B82),
                    child: Icon(Icons.person, color: Colors.white),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Search + Category
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
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Center(
                      child: Text("Category"),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Member List
            Expanded(
              child: ListView.builder(
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
                              member.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff197B82),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: member.isActive
                                    ? Colors.green.shade200
                                    : Colors.red.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                member.isActive ? "Active Member" : "Inactive",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "registered ${member.date}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  member.isActive = !member.isActive;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                              ),
                              child: Text(
                                member.isActive ? "Set Inactive" : "Set Active",
                              ),
                            ),
                            const SizedBox(height: 10),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  members.removeAt(index);
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}