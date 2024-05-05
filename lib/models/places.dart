class Places {
  final int id;
  final int? areaId;
  final int? cityId;
  final String name;

  Places({
    required this.id,
    this.areaId,
    this.cityId,
    required this.name,
  });

  factory Places.fromJson(Map<String, dynamic> jsonData) {
    return Places(
      id: jsonData['id'],
      areaId: jsonData['area_id'],
      cityId: jsonData['city_id'],
      name: jsonData['name'],
    );
  }
}
