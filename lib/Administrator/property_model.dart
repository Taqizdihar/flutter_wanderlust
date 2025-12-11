class PropertyModel {
  String name;
  String owner;
  String status;
  String category;
  String hours;
  String price;
  String quota;
  String address;
  String description;
  String picNumber;

  PropertyModel({
    required this.name,
    required this.owner,
    this.status = "Pending",
    required this.category,
    required this.hours,
    required this.price,
    required this.quota,
    required this.address,
    required this.description,
    required this.picNumber,
  });
}
