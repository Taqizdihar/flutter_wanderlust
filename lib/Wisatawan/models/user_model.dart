class UserModel {
  final int idUser;
  final int idWisatawan;
  final String nama;
  final String email;
  final String nomorTelepon;
  final String tanggalLahir;
  final String gender;
  final String alamat;
  final String kotaAsal;
  final String fotoProfil;

  const UserModel({
    required this.idUser,
    required this.idWisatawan,
    required this.nama,
    required this.email,
    required this.nomorTelepon,
    required this.tanggalLahir,
    required this.gender,
    required this.alamat,
    required this.kotaAsal,
    required this.fotoProfil,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['id_user'] ?? 0,
      idWisatawan: json['id_wisatawan'] ?? 0,
      nama: json['nama'] ?? '',
      email: json['email'] ?? '',
      nomorTelepon: json['nomor_telepon'] ?? '',
      tanggalLahir: json['tanggal_lahir'] ?? '',
      gender: json['jenis_kelamin'] ?? '',
      alamat: json['alamat'] ?? '',
      kotaAsal: json['kota_asal'] ?? '',
      fotoProfil: json['foto_profil'] ?? 'https://i.pravatar.cc/300',
    );
  }
}