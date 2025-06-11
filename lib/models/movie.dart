// File: frontend/lib/models/movie.dart

class Movie {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String,
      releaseDate: DateTime.parse(json['releaseDate'] as String),
    );
  }
}


// class MovieModel {
//   final int id;
//   final String title;
//   final String summary;
//   final String imageUrl;
//   final String description;
//   final DateTime releaseDate;

//   MovieModel({
//     required this.id,
//     required this.title,
//     required this.summary,
//     required this.imageUrl,
//     required this.description,
//     required this.releaseDate,
//   });

//   factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
//     id: json['id'],
//     title: json['title'],
//     summary: json['summary'],
//     imageUrl: json['imageUrl'],
//     description: json['description'],
//     releaseDate: json['releaseDate'],
//   );
// }
