class FavouriteProductModel {
  String id;
  bool status;
  FavouriteProductModel({required this.id, required this.status});

  factory FavouriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavouriteProductModel(
      id: json['product_id'],
      status: json['status'] ?? false,
    );
  }
}
