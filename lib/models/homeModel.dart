import 'package:e_commerce/models/settingsModel.dart';

class HomeModel {
  final WhatsApp whatsapp;
  final List<BannerModel> banners;
  final List<Category> categories;
  final List<Product> products;
  final List<Accessory> accessories;
  final String fName;
  final String lName;
  final List<SettingsModel>? settings;

  HomeModel({
    required this.whatsapp,
    required this.banners,
    required this.categories,
    required this.products,
    required this.accessories,
    required this.fName,
    required this.lName,
    this.settings,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      whatsapp: WhatsApp.fromJson(json['whatsapp']),
      banners: List<BannerModel>.from(
        json['banners'].map((banner) => BannerModel.fromJson(banner)),
      ),
      categories: List<Category>.from(
        json['categories'].map((category) => Category.fromJson(category)),
      ),
      products: List<Product>.from(
        json['products'].map((product) => Product.fromJson(product)),
      ),
      accessories: List<Accessory>.from(
        json['accssories'].map((accessory) => Accessory.fromJson(accessory)),
      ),
      fName: json['f_name'],
      lName: json['l_name'],
      settings: List<SettingsModel>.from(
        json['settings'].map((setting) => SettingsModel.fromJson(setting)),
      ),
    );
  }
}
class WhatsApp {
  final String url;

  WhatsApp({required this.url});

  factory WhatsApp.fromJson(Map<String, dynamic> json) {
    return WhatsApp(
      url: json['url'],
    );
  }
}

class BannerModel {
  final int id;
  final String image;

  BannerModel({required this.id, required this.image});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      image: json['image'],
    );
  }
}

class Category {
  final int id;
  final String name;
  final String image;
final String color;
  Category({required this.id, required this.name, required this.image, required this.color});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      color: json['color']
    );
  }
}

class Product {
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
  final bool? favorite;
  final Brand brand;

  Product({
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
     this.favorite,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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
      favorite: json['favorite'],
      brand: Brand.fromJson(json['brand']),
    );
  }
}

class Brand {
  final int id;
  final String name;
  final String image;

  Brand({required this.id, required this.name, required this.image});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class Accessory {
  final int id;
  final String name;
  final String description;
  final String image;
  final String price;
  final int quantity;
  bool? favorite;

  Accessory({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
    this.favorite,
  });

  factory Accessory.fromJson(Map<String, dynamic> json) {
    return Accessory(
      id: json['id'],
      name: json['name']??'',
      description: json['description']??'',
      image: json['image'],
      price: json['price']??'00.00',
      quantity: json['quantity']??5,
      favorite: json['favorite']?? false,
    );
  }
}


