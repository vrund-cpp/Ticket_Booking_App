class BookingHistory {
final String id;
final double entryAmount;
final double parkingAmount;
final double attractionAmount;
final double movieAmount;
final double total;
final String formattedDate;
  final String statusText;

BookingHistory({
required this.id,
required this.entryAmount,
required this.parkingAmount,
required this.attractionAmount,
required this.movieAmount,
required this.total,
required this.formattedDate,
    required this.statusText,
});

factory BookingHistory.fromJson(Map<String, dynamic> json) {
return BookingHistory(
id: json['id'],
entryAmount: (json['entryAmount'] as num).toDouble(),
parkingAmount: (json['parkingAmount'] as num).toDouble(),
attractionAmount: (json['attractionAmount'] as num).toDouble(),
movieAmount: (json['movieAmount'] as num).toDouble(),
total: (json['total'] as num).toDouble(),
formattedDate: json['createdAt'],
statusText: json['status'],
);
}
}