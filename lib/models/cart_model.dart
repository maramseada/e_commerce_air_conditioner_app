import 'brandModel.dart';

class CartModel {
  final int id;
  final int userId;
  final String total;
  final String discountValue;
  final String addedValue;
   int? promoCodeId;
  final String grandTotal;
  int? addressId;
  final List<CartProduct> cartProducts;
  final List<CartAccessory> cartAccessories;

  CartModel({
    required this.id,
    required this.userId,
    required this.total,
    required this.discountValue,
    required this.addedValue,
     this.promoCodeId,
    required this.grandTotal,
    required this.addressId,
    required this.cartProducts,
    required this.cartAccessories,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['user_id'],
      total: json['total'],
      discountValue: json['discount_value'],
      addedValue: json['added_value'],
      promoCodeId: json['promo_code_id'],
      grandTotal: json['grand_total']?? '',
      addressId: json['address_id'],
      cartProducts: (json['cart_products'] as List)
          .map((productJson) => CartProduct.fromJson(productJson))
          .toList(),
      cartAccessories: (json['cart_accessories'] as List)
          .map((accessoryJson) => CartAccessory.fromJson(accessoryJson))
          .toList(),

    );
  }
}

class CartProduct {
  final int id;
  final int cartId;
  final int quantity;
  final int productId;
  final int addsProductId;
  final ProductModel product;
  final AddModel add;

  CartProduct({
    required this.id,
    required this.cartId,
    required this.quantity,
    required this.productId,
    required this.addsProductId,
    required this.product,
    required this.add,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      cartId: json['cart_id'],
      quantity: json['quantity'],
      productId: json['product_id'],
      addsProductId: json['adds_product_id'],
      product: ProductModel.fromJson(json['product']),
      add: AddModel.fromJson(json['add']),
    );
  }
}

class ProductModel {
  final int id;
  final String name;
  final int productCategoryId;
  final int productBrandId;
  final String price;
  final String description;
  final String mainImage;
  final List<String> images;
  final int totalRate;
  final int quantity;
  final BrandModel brand;


  ProductModel({
    required this.id,
    required this.name,
    required this.productCategoryId,
    required this.productBrandId,
    required this.price,
    required this.description,
    required this.mainImage,
    required this.images,
    required this.totalRate,
    required this.quantity,
    required  this.brand,

  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      productCategoryId: json['product_category_id'],
      productBrandId: json['product_brand_id'],
      price: json['price'],
      description: json['description'],
      mainImage: json['main_image'],
      images: List<String>.from(json['images']),
      totalRate: json['total_rate'],
      quantity: json['quantity'],
      brand: BrandModel.fromJson(json['brand'] ?? {}),

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

  factory AddModel.fromJson(Map<String, dynamic> json) {
    return AddModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}

class CartAccessory {
  final int id;
  final int cartId;
  final int quantity;
  final int accessoryId;
  final AccessoryModel accessory;

  CartAccessory({
    required this.id,
    required this.cartId,
    required this.quantity,
    required this.accessoryId,
    required this.accessory,
  });

  factory CartAccessory.fromJson(Map<String, dynamic> json) {
    return CartAccessory(
      id: json['id'],
      cartId: json['cart_id'],
      quantity: json['quantity'],
      accessoryId: json['accessory_id'],
      accessory: AccessoryModel.fromJson(json['accessory']),
    );
  }
}

class AccessoryModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final List<String> images;
  final int totalRate;
  final String price;
  final int quantity;

  AccessoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.images,
    required this.totalRate,
    required this.price,
    required this.quantity,
  });

  factory AccessoryModel.fromJson(Map<String, dynamic> json) {
    return AccessoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      images: List<String>.from(json['images']),
      totalRate: json['total_rate'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}


