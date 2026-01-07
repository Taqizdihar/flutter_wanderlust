class PropertyAdminModel {
  final int idWisata;
  final String name;
  final String ownerName;
  final String status;
  final String category;
  final String address;
  final String price;
  final String image;

  PropertyAdminModel({
    required this.idWisata,
    required this.name,
    required this.ownerName,
    required this.status,
    required this.category,
    required this.address,
    required this.price,
    required this.image,
  });

  factory PropertyAdminModel.fromJson(Map<String, dynamic> json) {
    return PropertyAdminModel(
      idWisata: json['id_wisata'] ?? 0,
      name: json['nama_wisata'] ?? "",
      ownerName: json['owner_name'] ?? "Unknown",
      status: json['status_wisata'] ?? "Pending",
      category: json['jenis_wisata'] ?? "General",
      address: json['alamat_wisata'] ?? "",
      price: "Rp. ${json['harga_tiket'] ?? 0}",
      image: json['foto_utama'] ?? "https://picsum.photos/200",
    );
  }
}