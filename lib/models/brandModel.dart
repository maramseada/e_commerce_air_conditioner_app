class BrandModel {
  final int id;
  final String name;
  final String image;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
  });

  factory BrandModel.fromJson(Map<String, dynamic> jsonData) {

    return BrandModel(
      id: jsonData['id'],
      name: jsonData['name'] ?? '',
      image: jsonData['image'] ?? '',

    );
  }
}
