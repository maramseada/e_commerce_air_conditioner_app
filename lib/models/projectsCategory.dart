class Projects {
  final int id;
  final String name;
  final String image;

  Projects({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Projects.fromJson(Map<String, dynamic> jsonData) {
    return Projects(
      id: jsonData['id'],
      name: jsonData['name'] ?? '', // Handle null value by providing a default empty string
      image: jsonData['image'],
    );
  }
}
