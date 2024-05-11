import 'package:e_commerce/models/user.dart';

class AccessoryModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final List<String>? images;
  final String price;
  final int quantity;
  final int? totalRate;
  bool? favorite;
  final List<ReviewsAccessoryModel>? reviews;

  AccessoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    this.images,
    required this.price,
    required this.quantity,
    this.favorite,
    this.totalRate,
    this.reviews,
  });

  factory AccessoryModel.fromJson(Map<String, dynamic> jsonData) {
    List<dynamic> reviewsJson = jsonData['reviews'] ?? [];
    List<ReviewsAccessoryModel> reviewProducts = reviewsJson.map((item) => ReviewsAccessoryModel.fromJson(item)).toList();
    return AccessoryModel(
      id: jsonData['id'] ?? 0,
      name: jsonData['name'] ?? '',
      description: jsonData['description'] ?? '',
      image: jsonData['image'] ?? '',
      images: List<String>.from(jsonData['images'] ?? []),
      price: jsonData['price'] ?? '',
      quantity: jsonData['quantity'] ?? 0,
      favorite: jsonData['favorite'] ?? false,
      totalRate: jsonData['total_rate'] ?? 0, // Corrected field name to totalRate
      reviews: reviewProducts,
    );
  }

}
class ReviewsAccessoryModel {
  final int id;
  final String comment;
  final int rate;
  final int productId;
  final int userId;
  final String? createdAt;
  final User? user;

  ReviewsAccessoryModel(
      {required this.id, required this.comment, required this.rate, required this.productId, required this.userId, this.createdAt, this.user});
  factory ReviewsAccessoryModel.fromJson(Map<String, dynamic> jsonData) {
    return ReviewsAccessoryModel(
      id: jsonData['id'] ?? 0,
      comment: jsonData['comment'] ?? '',
      rate: jsonData['rate'] ?? 5,
      productId: jsonData['accessory_id'] ?? 0,
      userId: jsonData['user_id'] ?? 0,
      createdAt: jsonData['created_at'] ?? '',
      user: User.fromJson(jsonData['user'] ?? {}),
    );
  }

}