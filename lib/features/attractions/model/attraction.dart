// // File: frontend/lib/models/attraction_item.dart
class Attraction {
  final int id;
  final String title;
  final String description;
  final String? imageUrl;
  final double priceAdult;
  final double priceKid;
  final double priceSchool;
  final DateTime createdAt;
  bool selected;

  Attraction({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.priceAdult,
    required this.priceKid,
    required this.priceSchool,
    required this.createdAt,
    this.selected = false,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) {
    return Attraction(
      id: json['id'] as int,
      title: (json['title'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      imageUrl: json['imageUrl'] as String,
      priceAdult: ((json['priceAdult'] ?? 0) as num).toDouble(),
      priceKid: ((json['priceKid'] ?? 0) as num).toDouble(),
      priceSchool: ((json['priceSchool'] ?? 0) as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
