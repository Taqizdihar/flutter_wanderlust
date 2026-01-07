class AdminStats {
  final String totalMembers;
  final String totalProperties;
  final String totalOwners;
  final String totalRevenue;

  AdminStats({
    required this.totalMembers,
    required this.totalProperties,
    required this.totalOwners,
    required this.totalRevenue,
  });

  factory AdminStats.fromJson(Map<String, dynamic> json) {
    return AdminStats(
      totalMembers: json['total_members']?.toString() ?? "0",
      totalProperties: json['total_properties']?.toString() ?? "0",
      totalOwners: json['total_owners']?.toString() ?? "0",
      totalRevenue: json['total_revenue'] ?? "Rp. 0",
    );
  }
}