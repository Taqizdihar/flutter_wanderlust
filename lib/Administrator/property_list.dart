import 'package:flutter/material.dart';
import 'property_verification.dart';
import 'property_model.dart';

class PropertyListPage extends StatefulWidget {
  PropertyListPage({super.key});

  @override
  State<PropertyListPage> createState() => _PropertyListPageState();
}

class _PropertyListPageState extends State<PropertyListPage> {
List<PropertyModel> properties = [
  PropertyModel(
    name: "Sarae Hills",
    owner: "Saraeliel Sumardi",
    category: "Culinary",
    hours: "08:00 - 21:00",
    price: "Rp. 50.000 - 150.000",
    quota: "500 tickets",
    address: "Jl. Pagermaneuh, RT.05/RW./07, Pagerwangi, Kec. Lembang, Kab Bandung Barat",
    description: "Sarae Hills adalah destinasi wisata dengan replika ikon dunia yang estetik.",
    picNumber: "0812-2112-2211",
    imagePath: "assets/images/Sarae hills.jpeg",
    imagePath2: "assets/images/Sarae hills.jpeg",
  ),
  PropertyModel(
    name: "Dago Hills",
    owner: "Saraeliel Sumardi",
    category: "Culinary",
    hours: "09:00 - 20:00",
    price: "Rp. 40.000 - 120.000",
    quota: "400 tickets",
    address: "Bandung Utara",
    description: "Nikmati pemandangan kota Bandung dari ketinggian Dago Hills.",
    picNumber: "0812-5678-9876",
    imagePath: "assets/images/Dago hills.jpeg",
    imagePath2: "assets/images/Dago hills.jpeg",


  ),
  PropertyModel(
    name: "Kawah Putih Ciwidey",
    owner: "Saraeliel Sumardi",
    category: "Nature",
    hours: "07:00 - 17:00",
    price: "Rp. 30.000 - 80.000",
    quota: "1000 tickets",
    address: "Ciwidey, Kabupaten Bandung",
    description: "Danau kawah vulkanik dengan air berwarna putih kehijauan yang ikonik.",
    picNumber: "0812-3344-5566",
    imagePath: "assets/images/Kawah putih ciwidey.jpeg",
    imagePath2: "assets/images/Kawah putih ciwidey.jpeg"
  ),
  PropertyModel(
    name: "Kebun Teh Sukawana",
    owner: "Saraeliel Sumardi",
    category: "Nature",
    hours: "06:00 - 18:00",
    price: "Rp. 10.000 - 25.000",
    quota: "300 tickets",
    address: "Lembang, Bandung Barat",
    description: "Hamparan kebun teh hijau yang menyejukkan mata di kaki Gunung Tangkuban Perahu.",
    picNumber: "0812-9988-7766",
    imagePath: "assets/images/Kebun teh sukawana.jpeg",
    imagePath2: "assets/images/Kebun teh sukawana.jpeg",

  ),
  PropertyModel(
    name: "Lembang Park Zoo",
    owner: "Saraeliel Sumardi",
    category: "Family & Zoo",
    hours: "09:00 - 17:00",
    price: "Rp. 50.000 - 70.000",
    quota: "1500 tickets",
    address: "Jl. Kolonel Masturi No.171, Lembang",
    description: "Kebun binatang modern dengan konsep taman bermain yang seru untuk keluarga.",
    picNumber: "0813-1122-3344",
    imagePath: "assets/images/Lembang park zoo.jpeg",
    imagePath2: "assets/images/Lembang park zoo.jpeg",
  ),
  PropertyModel(
    name: "Museum Geologi",
    owner: "Saraeliel Sumardi",
    category: "Education",
    hours: "09:00 - 15:00",
    price: "Rp. 3.000 - 10.000",
    quota: "200 tickets",
    address: "Jl. Diponegoro No.57, Bandung",
    description: "Museum bersejarah yang menyimpan koleksi fosil purba dan kekayaan geologi Indonesia.",
    picNumber: "0812-0000-1111",
    imagePath: "assets/images/Museum Geologi.jpeg",
    imagePath2: "assets/images/Museum Geologi.jpeg",


  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Property List",
            style: TextStyle(
                fontSize: 24, color: Color(0xFF0A6A84), fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name,
                        style: const TextStyle(
                            fontSize: 20, color: Colors.white)),
                    Text(p.status,
                        style: const TextStyle(color: Colors.white)),
                    Text("Owner: ${p.owner}",
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),

                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PropertyVerificationPage(property: p),
                      ),
                    );

                    if (result == "approved") {
                      setState(() {
                        p.status = "Selesai";
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Property updated"),
                        ),
                      );
                    }
                  },
                  child: const Text("Actions"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
