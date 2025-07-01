// // lib/models/booking_summary.dart

// class BookingSummary {
//   final List<String> entryTickets;
//   final List<String> parkings;
//   final List<String> attractions;
//   final List<String> movies;

//   BookingSummary({
//     required this.entryTickets,
//     required this.parkings,
//     required this.attractions,
//     required this.movies,
//   });

//   factory BookingSummary.fromJson(Map<String, dynamic> json) {
//     return BookingSummary(
//       entryTickets: List<String>.from(json['entryTickets'] ?? []),
//       parkings: List<String>.from(json['parkings'] ?? []),
//       attractions: List<String>.from(json['attractions'] ?? []),
//       movies: List<String>.from(json['movies'] ?? []),
//     );
//   }
// }

class BookingItem {
  final String type;
  final int quantity;
  final double pricePerUnit;
  final String? name;

  BookingItem({
    required this.type,
    required this.quantity,
    required this.pricePerUnit,
    this.name,
  });

  factory BookingItem.fromJson(Map<String, dynamic> json) {
    return BookingItem(
      type: json['type'] as String,
      quantity: json['quantity'] as int,
      pricePerUnit: (json['pricePerUnit'] as num).toDouble(),
      name: json['name'] as String?,
    );
  }

  double get total => quantity * pricePerUnit;
}

class BookingSummary {
  final List<BookingItem> items;
  final double total;

  BookingSummary({
    required this.items,
    required this.total,
  });

  factory BookingSummary.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] as List;
    return BookingSummary(
      items: itemsJson.map((e) => BookingItem.fromJson(e)).toList(),
      total: (json['total'] as num).toDouble(),
    );
  }
}

