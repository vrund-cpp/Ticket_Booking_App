// File: frontend/lib/models/attraction_item.dart

class Attraction {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdAt;

  Attraction({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) {
    return Attraction(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String), 
    );
  }
}

