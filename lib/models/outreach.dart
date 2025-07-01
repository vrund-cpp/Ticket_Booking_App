// File: frontend/lib/models/outreach_item.dart

class Outreach {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime Startdate;
  final DateTime Enddate;
  final DateTime createdAt;

  Outreach({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.Startdate,
    required this.Enddate,
    required this.createdAt,
  });

  factory Outreach.fromJson(Map<String, dynamic> json) {
    return Outreach(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String,
      Startdate: DateTime.parse(json['Startdate'] as String),
      Enddate: DateTime.parse(json['Enddate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}


