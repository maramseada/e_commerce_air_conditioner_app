class Project {
  final int id;
  final int project_category_id;
  final String title;
  final String image;
  final String location;
  final String air_condition_type;
  final String? created_at;
  final String? updated_at;

  Project({
    required this.id,
    required this.project_category_id,
    required this.title,
    required this.image,
    required this.location,
    required this.air_condition_type,
     this.created_at,
     this.updated_at,
  });

  factory Project.fromJson(Map<String, dynamic> jsonData) {
    return Project(
      id: jsonData['id'],
      project_category_id: jsonData['project_category_id'],
      title: jsonData['title']?? '',
      image: jsonData['image']?? '',
      location: jsonData['location']?? '',
      air_condition_type: jsonData['air_condition_type']?? '',
      created_at: jsonData['created_at'],
      updated_at: jsonData['updated_at'],
    );
  }
}
