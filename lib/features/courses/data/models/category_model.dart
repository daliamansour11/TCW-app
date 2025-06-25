
class CategoryModel {

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      parentId: json['parent_id'],
      name: json['name'],
      image: json['image'],
      position: json['position'],
      description: json['description'],
      isActive: json['is_active'] == 1,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      courseCount: json['course_count'],
    );
  }

  CategoryModel({
    required this.id,
    required this.parentId,
    required this.name,
    required this.image,
    required this.position,
    this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.courseCount,
  });
  final int id;
  final int parentId;
  final String name;
  final String image;
  final int position;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int courseCount;
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'name': name,
      'image': image,
      'position': position,
      'description': description,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'course_count': courseCount,
    };
  }
}