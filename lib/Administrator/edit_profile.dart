import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Color primaryColor = const Color(0xFF0A6A84);
  
  // Controller untuk menangkap inputan text
  final TextEditingController nameController = TextEditingController(text: "Riska Dea Bakri");
  final TextEditingController emailController = TextEditingController(text: "riska.dea@admin.com");
  final TextEditingController addressController = TextEditingController(text: "Jl. Properti No. 123, Bandung");
  final TextEditingController descController = TextEditingController(text: "Head Administrator untuk Manajemen Properti wilayah Jawa Barat.");
  final TextEditingController phoneController = TextEditingController(text: "+62 812-3456-7890");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Admin Profile"),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/user.jpg"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.camera_alt, size: 18, color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField("Nama Lengkap", nameController, Icons.person),
            _buildTextField("Email", emailController, Icons.email),
            _buildTextField("Alamat", addressController, Icons.location_on),
            _buildTextField("Deskripsi", descController, Icons.description, maxLines: 3),
            _buildTextField("Nomor Telepon", phoneController, Icons.phone),
            const SizedBox(height: 30),
            
            // Button Simpan
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  // Simulasi simpan data
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Data Berhasil Diperbarui!"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text("Simpan Perubahan", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: primaryColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
        ),
      ),
    );
  }
}