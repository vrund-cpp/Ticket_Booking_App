// File: frontend/lib/models/movie.dart

class Movie {
  final int id;
  final String title;
  final String  description;
  final String imageUrl;
  final DateTime releaseDate;
  final String? timeSlot;
  final int duration;
  final String? language;
  final String? format;
  final double priceAdult;
  final double priceKid;
  final double priceSchool;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.releaseDate,
     this.timeSlot,
    required this.duration,
     this.language,
     this.format,
    required this.priceAdult,
    required this.priceKid,
    required this.priceSchool,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
  return Movie(
    id: json['id'] as int,
    title: json['title'] as String? ?? '',
    description: json['description'] as String? ?? '',
    imageUrl: json['imageUrl'] as String? ?? '',
    releaseDate: DateTime.parse(json['releaseDate'] ?? DateTime.now().toIso8601String()),
    timeSlot: json['timeSlot'] as String? ?? '',
    duration: json['duration'] as int? ?? 0,
    language: json['language'] as String? ?? '',
    format: json['format'] as String? ?? 'Unknown', // <- FIXED
    priceAdult: (json['priceAdult'] as num?)?.toDouble() ?? 0.0,
    priceKid: (json['priceKid'] as num?)?.toDouble() ?? 0.0,
    priceSchool: (json['priceSchool'] as num?)?.toDouble() ?? 0.0,
  );
}

}
