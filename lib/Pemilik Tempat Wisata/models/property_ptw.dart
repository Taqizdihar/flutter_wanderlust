class PropertyPTW {
  final String name;
  final String status;
  final int tickets;
  final int favorites;
  final int sold;
  final int clicks;
  final String imageUrl;

  PropertyPTW({
    required this.name,
    required this.status,
    required this.tickets,
    required this.favorites,
    required this.sold,
    required this.clicks,
    required this.imageUrl,
  });

  // Fungsi untuk mengubah data JSON dari HTTP menjadi objek Dart
  factory PropertyPTW.fromJson(Map<String, dynamic> json) {
    return PropertyPTW(
      name: json['title'] ?? 'Nama Properti', // Menggunakan 'title' dari JSONPlaceholder sebagai simulasi
      status: 'Active',
      tickets: 100,
      favorites: 54,
      sold: 250,
      clicks: 400,
      imageUrl: 'https://picsum.photos/200',
    );
  }
}