class DashboardStats {
  final String totalIncome;
  final String totalVisitors;
  final String ticketSold;
  final String totalProperties;
  final String totalClicks;
  final String avgOrderValue;

  DashboardStats({
    required this.totalIncome,
    required this.totalVisitors,
    required this.ticketSold,
    required this.totalProperties,
    required this.totalClicks,
    required this.avgOrderValue,
  });

  // Fungsi untuk memetakan JSON simulasi ke objek statistik
  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalIncome: "25.000.000", // Simulasi data tetap
      totalVisitors: "205",
      ticketSold: "298",
      totalProperties: "3",
      totalClicks: "1468",
      avgOrderValue: "83.892",
    );
  }
}