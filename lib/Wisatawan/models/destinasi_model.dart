class Destinasi {
  final int id;
  final String nama;
  final String lokasi;
  final double rating;
  final int ulasan;
  final int harga;
  final String gambar;
  final String deskripsi;

  Destinasi({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.rating,
    required this.ulasan,
    required this.harga,
    required this.gambar,
    required this.deskripsi,
  });

  factory Destinasi.fromJson(Map<String, dynamic> json) {
    return Destinasi(
      id: json['id_wisata'] ?? 0, // Sesuai primary key TempatWisata.php
      nama: json['nama_wisata'] ?? 'Destinasi', 
      lokasi: json['kota'] ?? 'Indonesia',
      rating: (json['average_rating'] ?? 4.5).toDouble(),
      ulasan: json['total_reviews'] ?? 100,
      harga: json['harga_tiket'] ?? 0, // Diambil dari TiketTempatWisata.php
      gambar: json['foto_utama'] ?? 'https://picsum.photos/400/300',
      deskripsi: json['deskripsi'] ?? 'Deskripsi tidak tersedia.',
    );
  }
}