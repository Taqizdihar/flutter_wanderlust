import 'package:flutter/material.dart';
import 'owner_verification_page.dart'; // Import dari folder yang sama

class PropertyOwnerListPage extends StatefulWidget {
  const PropertyOwnerListPage({super.key});

  @override
  State<PropertyOwnerListPage> createState() => _PropertyOwnerListPageState();
}

class _PropertyOwnerListPageState extends State<PropertyOwnerListPage> {
  final Color mainColor = const Color(0xFF0A6A84);

  List<Map<String, dynamic>> owners = [
    {
      "name": "Guy Errand",
      "status": "Pending",
      "date": "28/4/2025",
      "image": "https://i.pravatar.cc/150?img=12" // Ganti dummy image
    },
    {
      "name": "Laverinda",
      "status": "Active",
      "date": "12/3/2025",
      "image": "https://i.pravatar.cc/150?img=9"
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Active":
        return Colors.green;
      case "Revision":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Property Owner List",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: mainColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: owners.length,
        itemBuilder: (context, index) {
          var item = owners[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(18),
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(item["image"]),
              ),
              title: Text(
                item["name"],
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: getStatusColor(item["status"]),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      item["status"],
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "registered ${item["date"]}",
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, foregroundColor: mainColor),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OwnerVerificationPage(ownerData: item),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      owners[index]["status"] = result;
                    });
                  }
                },
                child: const Text("Actions"),
              ),
            ),
          );
        },
      ),
    );
  }
}