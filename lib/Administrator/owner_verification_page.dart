import 'package:flutter/material.dart';

class OwnerVerificationPage extends StatefulWidget {
  final Map<String, dynamic> ownerData;

  OwnerVerificationPage({required this.ownerData});

  @override
  State<OwnerVerificationPage> createState() => _OwnerVerificationPageState();
}

class _OwnerVerificationPageState extends State<OwnerVerificationPage> {
  final Color mainColor = const Color(0xFF0A6A84);
  String currentStatus = "";

  @override
  void initState() {
    super.initState();
    currentStatus = widget.ownerData["status"];
  }

  @override
  Widget build(BuildContext context) {
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

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(widget.ownerData["image"]),
            ),

            SizedBox(height: 14),

            Text(
              widget.ownerData["name"],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),

            SizedBox(height: 20),

            buildDetail("Full Name", widget.ownerData["name"]),
            buildDetail("Email", "guseo.business@gmail.com"),
            buildDetail("Phone Number", "0898-7654-321"),

            buildDetail(
              "Business Address",
              "Jl. Kemakmuran Bangsa No. 9, Pehape, Malabari, Bandung, Jawa Barat, Indonesia.",
            ),

            SizedBox(height: 20),

            buildDocumentButton("See Tax Document"),
            SizedBox(height: 12),
            buildDocumentButton("See Legal Business Document"),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                setState(() => currentStatus = "Active");
                Navigator.pop(context, "Active");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Approve", style: TextStyle(fontSize: 18)),
            ),

            SizedBox(height: 14),

            ElevatedButton(
              onPressed: () {
                setState(() => currentStatus = "Revision");
                Navigator.pop(context, "Revision");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Revision", style: TextStyle(fontSize: 18)),
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
          Text(
            "$title:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: mainColor,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDocumentButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
          Icon(Icons.open_in_new, color: Colors.white),
        ],
      ),
    );
  }
}
