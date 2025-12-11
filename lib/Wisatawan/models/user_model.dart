class UserModel {
  final String nama;
  final String email;
  final String nomorTelepon;
  final String tanggalLahir;
  final String gender;
  final String alamat;
  final int totalKunjungan;
  final double totalPengeluaran;
  final String asetProfil; 

  const UserModel({
    required this.nama,
    required this.email,
    required this.nomorTelepon,
    required this.tanggalLahir,
    required this.gender,
    required this.alamat,
    this.totalKunjungan = 0,
    this.totalPengeluaran = 0.0,
    required this.asetProfil,
  });
}