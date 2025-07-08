import 'package:flutter_test/flutter_test.dart';

class BookingCartProvider {
  int count = 0;
  int price = 0;
  int get totalAmount => count * price;

  void setCount(int c) => count = c;
  void setPrice(int p) => price = p;
}

void main() {
  test('Total amount should be calculated correctly', () {
    final provider = BookingCartProvider();
    provider.setCount(2);
    provider.setPrice(150);
    expect(provider.totalAmount, 300);
  });
}
