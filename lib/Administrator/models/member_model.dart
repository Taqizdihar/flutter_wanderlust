class MemberModel {
  final int idUser;
  final String name;
  final bool isActive;
  final String registrationDate;
  final String email;

  MemberModel({
    required this.idUser,
    required this.name,
    required this.isActive,
    required this.registrationDate,
    required this.email,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      idUser: json['id_user'] ?? 0,
      name: json['nama'] ?? "No Name",
      isActive: json['status_akun'] == 'aktif',
      registrationDate: json['created_at'] ?? "-",
      email: json['email'] ?? "",
    );
  }
}