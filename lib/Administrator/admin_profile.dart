import 'package:flutter/material.dart';
import '../login.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  final Color mainColor = const Color(0xFF0A6A84);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: mainColor, width: 2),
            ),
            child: Icon(Icons.arrow_back, color: mainColor, size: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 1),

            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: mainColor, width: 3),
              ),
              child: const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/images/man 2.jpg"),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Administrator",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),

            const Spacer(flex: 2),

            const Divider(color: Colors.red, thickness: 1.5),

            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.exit_to_app, color: Colors.red, size: 32),
                    const SizedBox(width: 16),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Log Out",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Log out from your account",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.red,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
