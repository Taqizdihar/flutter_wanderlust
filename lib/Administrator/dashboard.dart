import 'package:flutter/material.dart';
import 'property_list.dart';
import 'member_list.dart';
import 'property_owner_list.dart';
import 'admin_profile.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  final Color mainColor = const Color(0xFF0A6A84);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      bottomNavigationBar: _bottomNavBar(),
      body: Stack(
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [mainColor.withOpacity(0.8), mainColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _header(context),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MemberListPage(),
                            ),
                          );
                        },
                        child: _statCard(Icons.people, "Total Members", "137"),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PropertyListPage(),
                            ),
                          );
                        },
                        child: _statCard(
                          Icons.home_work,
                          "Total Properties",
                          "34",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PropertyOwnerListPage(),
                            ),
                          );
                        },
                        child: _statCard(Icons.groups, "Owner List", "67"),
                      ),

                      _statCard(
                        Icons.account_balance_wallet,
                        "Total Top Up",
                        "32",
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  _wideCard(
                    icon: Icons.monetization_on,
                    title: "Accumulated Revenues",
                    value: "Rp. 3.000.000",
                  ),

                  const SizedBox(height: 20),

                  _wideCard(
                    icon: Icons.bar_chart,
                    title: "Average Revenues Per Transaction",
                    value: "Rp. 150.000",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Welcome",
              style: TextStyle(color: Colors.white70, fontSize: 20),
            ),
            SizedBox(height: 6),
            Text(
              "Riska Dea Bakri",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
            ),
          ],
        ),

        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminProfilePage()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage("assets/images/man 2.jpg"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statCard(IconData icon, String title, String value) {
    const Color mainColor = Color(0xFF0A6A84);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 160,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: mainColor.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: mainColor),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: mainColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: mainColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _wideCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    const Color mainColor = Color(0xFF0A6A84);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: mainColor.withOpacity(0.2),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 36, color: mainColor),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: mainColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  color: mainColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(color: Color(0xFF0A6A84)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.home, color: Colors.white, size: 32),
          Icon(Icons.person, color: Colors.white, size: 32),
          Icon(Icons.settings, color: Colors.white, size: 32),
          Icon(Icons.groups, color: Colors.white, size: 32),
        ],
      ),
    );
  }
}
