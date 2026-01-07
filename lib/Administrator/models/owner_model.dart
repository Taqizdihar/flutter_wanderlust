class OwnerModel {
  final int idUser;
  final int idPtw;
  final String name;
  final String status;
  final String email;
  final String phone;
  final String organization;
  final String image;
  final String registrationDate;

  OwnerModel({
    required this.idUser,
    required this.idPtw,
    required this.name,
    required this.status,
    required this.email,
    required this.phone,
    required this.organization,
    required this.image,
    required this.registrationDate,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      idUser: json['id_user'] ?? 0,
      idPtw: json['id_ptw'] ?? 0,
      name: json['nama'] ?? "",
      status: json['status_akun'] ?? "Pending",
      email: json['email'] ?? "",
      phone: json['nomor_telepon'] ?? "",
      organization: json['nama_organisasi'] ?? "-",
      image: json['foto_profil'] ?? "https://i.pravatar.cc/300",
      registrationDate: json['created_at'] ?? "-",
    );
  }
}