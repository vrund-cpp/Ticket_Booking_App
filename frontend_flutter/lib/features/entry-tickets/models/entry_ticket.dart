class EntryTicket {
  final String id;
  final String name;
  final String? description;
  final double price;
   int count;
  final String? iconUrl;

  EntryTicket({
    required this.id,
    required this.name,
     this.description,
    required this.price,
    this.count = 0,
     this.iconUrl,
  });

  factory EntryTicket.fromJson(Map<String, dynamic> json) {
    return EntryTicket(
      id: json['id'] as String ,
      name: json['name'] as String ,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      iconUrl: json['iconUrl'] as String ,
    );
  }
}
