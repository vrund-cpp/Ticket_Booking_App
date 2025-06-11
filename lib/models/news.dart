// lib/models/news.dart

class News {
  final int id;
  final String? summary;
  final DateTime? date;
  final DateTime createdAt;

  News({
    required this.id,
    this.summary,
    this.date,
    required this.createdAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] as int,
      summary: json['sumarry'] as String?,
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
