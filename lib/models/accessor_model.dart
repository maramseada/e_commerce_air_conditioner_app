class AccessoryModel {
  final int id;
  final String name;
  final String price;
  final String description;
  final String image;
  final int quantity;
  // final List<String> images;
  // final int totalRate;

  // final List<ReviewsModel>? reviews;

  AccessoryModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.quantity,
  });

  factory AccessoryModel.fromJson(Map<String, dynamic> jsonData) {
    return AccessoryModel(
      id: jsonData['id'],
      name: jsonData['name'] ?? '',
      price: jsonData['price'] ?? '',
      description: jsonData['description'] ?? '',
      image: jsonData['image'] ?? '',
      quantity: jsonData['quantity'] ?? 0,
    );
  }
}
