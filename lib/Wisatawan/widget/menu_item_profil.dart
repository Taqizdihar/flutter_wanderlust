import 'package:flutter/material.dart';

class MenuItemProfil extends StatelessWidget {
  final IconData ikon;
  final String judul;
  final String deskripsi;
  final Color warna;
  final VoidCallback onTap;
  final bool border; 

  const MenuItemProfil({
    super.key,
    required this.ikon,
    required this.judul,
    required this.deskripsi,
    required this.warna,
    required this.onTap,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(ikon, color: warna, size: 28),
          title: Text(
            judul,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: warna,
            ),
          ),
          subtitle: Text(
            deskripsi,
            style: const TextStyle(fontSize: 12),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: onTap,
        ),
        if (border) 
          Divider(color: warna, thickness: 1.5, height: 0),
      ],
    );
  }
}