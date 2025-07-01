enum UserType {
adult,
kid,
school,
}

class VisitorSlot {
final int attractionId; // also used for Movie ID
final UserType type;
int count;
final double price;

VisitorSlot({
required this.attractionId,
required this.type,
required this.count,
required this.price,
});

double get total => count * price;
}