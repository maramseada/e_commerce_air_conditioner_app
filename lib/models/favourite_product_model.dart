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


class FavouriteAccessoryModel {
  String id;
  bool status;
  FavouriteAccessoryModel({required this.id, required this.status});

  factory FavouriteAccessoryModel.fromJson(Map<String, dynamic> json) {
    return FavouriteAccessoryModel(
      id: json['accessory_id'],
      status: json['status'] ?? false,
    );
  }
}
