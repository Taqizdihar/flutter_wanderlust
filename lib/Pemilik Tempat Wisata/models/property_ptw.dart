class PropertyPTW {
  final int id;
  final String name;
  final String status;
  final String location;
  final String imageUrl;

  PropertyPTW({
    required this.id,
    required this.name,
    required this.status,
    required this.location,
    required this.imageUrl,
  });

  factory PropertyPTW.fromJson(Map<String, dynamic> json) {
    return PropertyPTW(
      id: json['id'],
      name: json['name'] ?? 'No Name', 
      status: json['status'] ?? 'Pending',
      location: json['location'] ?? 'Unknown',
      imageUrl: json['image_url'] ?? 'https://picsum.photos/200',
    );
  }
}