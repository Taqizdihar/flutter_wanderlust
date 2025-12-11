import 'package:flutter/material.dart';
import 'property_model.dart';

class PropertyVerificationPage extends StatelessWidget {
  final PropertyModel property;

  const PropertyVerificationPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Property Verification",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF0A6A84),
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Text("Name: ${property.name}",
                  style: const TextStyle(fontSize: 18)),
              Text("Category: ${property.category}",
                  style: const TextStyle(fontSize: 18)),
              Text("Hours: ${property.hours}",
                  style: const TextStyle(fontSize: 18)),
              Text("Ticket Price: ${property.price}",
                  style: const TextStyle(fontSize: 18)),
              Text("Ticket Quota: ${property.quota}",
                  style: const TextStyle(fontSize: 18)),
              Text("Address: ${property.address}",
                  style: const TextStyle(fontSize: 18)),
              Text("Description: ${property.description}",
                  style: const TextStyle(fontSize: 18)),
              Text("PIC Number: ${property.picNumber}",
                  style: const TextStyle(fontSize: 18)),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "approved");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Approve",
                    style: TextStyle(fontSize: 18)),
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Revision",
                    style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
