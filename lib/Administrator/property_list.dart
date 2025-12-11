import 'package:flutter/material.dart';
import 'property_verification.dart';
import 'property_model.dart';

class PropertyListPage extends StatefulWidget {
  const PropertyListPage({super.key});

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
      address:
          "Jl. Pagermaneuh, RT.05/RW./07, Pagerwangi, Kec. Lembang, Kab Bandung Barat",
      description: "Sarae Hills adalah destinasi wisata...",
      picNumber: "0812-2112-2211",
    ),
    PropertyModel(
      name: "Dago Hills",
      owner: "Saraeliel Sumardi",
      category: "Culinary",
      hours: "09:00 - 20:00",
      price: "Rp. 40.000 - 120.000",
      quota: "400 tickets",
      address: "Bandung Utara",
      description: "Destinasi indah di Dago",
      picNumber: "0812-5678-9876",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0A6A84)),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Property List",
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF0A6A84),
            fontWeight: FontWeight.bold,
          ),
        ),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Status: ${p.status}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Owner: ${p.owner}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
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
                        p.status = "Active";
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Property Approved")),
                      );
                    }
                  },
                  child: const Text("Actions"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
