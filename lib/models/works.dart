class Works {
  final int id;
  final String type;
  final String description;
  final String image;

  Works({
    required this.id,
    required this.type,
    required this.description,
    required this.image,
  });

  factory Works.fromJson(Map<String, dynamic> jsonData) {
    return Works(
      id: jsonData['id'],
      type: jsonData['type'],
      description: jsonData['description'],
      image: jsonData['image'],
    );
  }
}
