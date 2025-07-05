enum VehicleType { two_wheeler, four_wheeler, school_bus }

class ParkingOption {
  final String id;
  final VehicleType vehicleType;
  final String? description;
  final double price;
  int count;

  ParkingOption({
    required this.id,
    required this.vehicleType,
    this.description,
    required this.price,
    this.count = 0,
  });

  factory ParkingOption.fromJson(Map<String, dynamic> json) {
    return ParkingOption(
      id: json['id'] as String,
      vehicleType: VehicleType.values.firstWhere(
        (e) => e.name == json['vehicleType'],
      ),
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
    );
  }
}
