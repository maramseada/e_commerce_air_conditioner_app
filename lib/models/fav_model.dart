import 'homeModel.dart';

class FavModel {
  final List<Product> products;
  final List<Accessory> accessories;
  FavModel({required this.products, required this.accessories});
  factory FavModel.fromJson(Map<String, dynamic> json) {
    return FavModel(
      products: List<Product>.from(
        json['products'].map((product) => Product.fromJson(product)),
      ),
      accessories: List<Accessory>.from(
        json['accessories'].map((accessory) => Accessory.fromJson(accessory)),
      ),

    );
  }
}
