// // lib/models/booking_summary.dart
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

