class SettingsModel {
  final int id;
  final String name;
  final String value;

  SettingsModel({
    required this.id,
    required this.value,
    required this.name,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> jsonData) {

    return SettingsModel(
      id: jsonData['id'],
      name: jsonData['name'] ?? '',
      value: jsonData['value'] ?? '',

    );
  }
}
