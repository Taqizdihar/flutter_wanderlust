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

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalIncome: json['total_income'] ?? "0",
      totalVisitors: json['total_visitors'] ?? "0",
      ticketSold: json['ticket_sold'] ?? "0",
      totalProperties: json['total_properties'] ?? "0",
      totalClicks: json['total_clicks'] ?? "0",
      avgOrderValue: json['avg_order_value'] ?? "0",
    );
  }
}