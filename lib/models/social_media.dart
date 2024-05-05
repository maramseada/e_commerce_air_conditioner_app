class SocialMediaModel {
  final int id;
  final String? name;
  final String? nameAr;
  final String? url;
  final String? active;
  final String? createdAt;
  final String? updatedAt;

  SocialMediaModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.url,
    required this.active,
    this.createdAt,
    this.updatedAt,
  });

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaModel(
      id: json['id'],
      name: json['name']?? '',
      nameAr: json['name_ar']??'',
      url: json['url']??'',
      active: json['active']??"",
      createdAt: json['created_at']??'',
      updatedAt: json['updated_at']??'',
    );
  }
}
