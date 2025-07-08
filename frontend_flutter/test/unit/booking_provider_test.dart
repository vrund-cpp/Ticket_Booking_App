import 'package:flutter_test/flutter_test.dart';

class BookingProvider {
  int quantity = 0;
  double price = 0;

  double get total => quantity * price;

  void add(int count) => quantity += count;
  void setPrice(double p) => price = p;
}

void main() {
  test('Booking total amount calculation', () {
    final provider = BookingProvider();
    provider.add(2);
    provider.setPrice(150);
    expect(provider.total, 300);
  });
}
