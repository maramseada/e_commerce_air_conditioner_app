import 'package:e_commerce/models/user.dart';

import 'address.dart';
import 'brandModel.dart';

class OrderModel {
  final int id;
  final String orderNum;
  final int userId;
  final int addressId;
  final String grandTotal;
  final String discountValue;
  final String addedValue;
  final String total;
  final String? promoCodeId;
  final String? payDate;
  final String? paymentReference;
  final String? card;
  final String status;
  final List<OrderProductsModel>? orderProduct;
  final List<OrderAccessoriesModel>? accessoryProduct;

  final Address? address;

  OrderModel({
    required this.id,
    required this.orderNum,
    required this.userId,
    required this.addressId,
    required this.grandTotal,
    required this.discountValue,
    required this.addedValue,
    required this.total,
    this.promoCodeId,
    this.card,
    this.paymentReference,
    required this.status,
    this.payDate,
    this.orderProduct,
    this.accessoryProduct,
    this.address,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> orderProductsJson = json['order_products'] ?? [];
    List<OrderProductsModel> orderProducts = orderProductsJson.map((item) => OrderProductsModel.fromJson(item)).toList();

    List<dynamic> orderAccessoriesJson = json['order_accessories'] ?? [];
    List<OrderAccessoriesModel> orderAccessories = orderAccessoriesJson.map((item) => OrderAccessoriesModel.fromJson(item)).toList();

    return OrderModel(
      id: json["id"],
      orderNum: json["order_num"],
      userId: json["user_id"],
      addressId: json['address_id'],
      grandTotal: json['grand_total'],
      discountValue: json['discount_value'],
      addedValue: json['added_value'],
      total: json['total'],
      promoCodeId: json['promo_code_id'],
      payDate: json['pay_date'],
      paymentReference: json['payment_reference'],
      card: json['card'],
      status: json['status'],
      orderProduct: orderProducts,
      accessoryProduct: orderAccessories,
      address: Address.fromJson(json['address'] ?? {}),
    );
  }
}

class OrderProductsModel {
  final int id;
  final int orderId;
  final int quantity;
  final int productId;
  final int addsProductId;
  final ProductsModel? product;
  final AddModel? adds;
  OrderProductsModel({
    required this.id,
    required this.orderId,
    required this.quantity,
    required this.productId,
    required this.addsProductId,
    this.product,
    this.adds,
  });

  factory OrderProductsModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderProductsModel(
      id: jsonData['id'],
      orderId: jsonData['order_id'],
      quantity: jsonData['quantity'],
      productId: jsonData['product_id'],
      addsProductId: jsonData['adds_product_id'],
      product: ProductsModel.fromJson(jsonData['product'] ?? {}),
      adds: AddModel.fromJson(jsonData['add'] ?? {}),
    );
  }
}

class ProductsModel {
  final int id;
  final String name;
  final int? categoryId;
  final int? brandId;
  final String price;
  final String description;
  final String image;
  final List<String> images;
  final int totalRate;
  final bool? favorite;
  final CategoryModel? category;
  final int quantity;
  final BrandModel? brand;
  final List<ReviewsModel>? reviews;

  ProductsModel({
    required this.id,
    required this.name,
    this.categoryId,
    this.brandId,
    required this.price,
    required this.description,
    required this.image,
    required this.images,
    required this.totalRate,
    required this.quantity,
    this.category,
    this.brand,
    this.reviews,
    this.favorite,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> jsonData) {
    List<dynamic> reviewsJson = jsonData['reviews'] ?? [];
    List<ReviewsModel> reviewProducts = reviewsJson.map((item) => ReviewsModel.fromJson(item)).toList();

    return ProductsModel(
      id: jsonData['id'],
      name: jsonData['name'] ?? '',
      categoryId: jsonData['product_category_id'] ?? 1,
      brandId: jsonData['product_brand_id'] ?? 1,
      price: jsonData['price'] ?? '',
      description: jsonData['description'] ?? '',
      image: jsonData['main_image'] ?? '',
      favorite: jsonData['favorite'],
      quantity: jsonData['quantity'],
      images: List<String>.from(jsonData['images'] ?? []),
      totalRate: jsonData['total_rate'] ?? 0,
      category: CategoryModel.fromJson(jsonData['category'] ?? {}),
      brand: BrandModel.fromJson(jsonData['brand'] ?? {}),
      reviews: reviewProducts, // Assign the mapped reviews list to the reviews field
    );
  }
}

class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({
    required this.id,
    required this.image,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> jsonData) {
    return CategoryModel(
      id: jsonData['id'] ?? 1,
      name: jsonData['name'] ?? '',
      image: jsonData['image'] ?? '',
    );
  }
}

class ReviewsModel {
  final int id;
  final String comment;
  final int rate;
  final int productId;
  final int userId;
  final String? createdAt;
  final User? user;

  ReviewsModel(
      {required this.id, required this.comment, required this.rate, required this.productId, required this.userId, this.createdAt, this.user});

  factory ReviewsModel.fromJson(Map<String, dynamic> jsonData) {
    return ReviewsModel(
      id: jsonData['id'],
      comment: jsonData['comment'] ?? '',
      rate: jsonData['rate'],
      productId: jsonData['product_id'],
      userId: jsonData['user_id'] ?? '',
      createdAt: jsonData['created_at'] ?? '',
      user: User.fromJson(jsonData['user'] ?? {}),
    );
  }
}

class AddModel {
  final int id;
  final String name;
  final String price;

  AddModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory AddModel.fromJson(Map<String, dynamic> jsonData) {
    return AddModel(
      id: jsonData['id'],
      name: jsonData['name'] ?? '',
      price: jsonData['price'] ?? '',
    );
  }
}

class OrderAccessoriesModel {
  final int id;
  final int orderId;
  final int quantity;
  final int accessoryId;
  final AccessoryModel? accessory;
  OrderAccessoriesModel({
    required this.id,
    required this.orderId,
    required this.quantity,
    required this.accessoryId,
    this.accessory,
  });

  factory OrderAccessoriesModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderAccessoriesModel(
      id: jsonData['id'] ?? '',
      orderId: jsonData['order_id'] ?? 0,
      quantity: jsonData['quantity'] ?? 0,
      accessoryId: jsonData['accessory_id'] ?? 0,
      accessory: AccessoryModel.fromJson(jsonData['accessory'] ?? {}),
    );
  }
}

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