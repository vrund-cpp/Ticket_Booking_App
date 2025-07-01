import 'package:flutter/material.dart';
import 'package:ticket_booking_app/models/attraction.dart';
import 'package:ticket_booking_app/models/movie.dart';
import 'package:ticket_booking_app/models/visitor_slot.dart';
import '../models/entry_ticket.dart';
import '../models/parking_option.dart';

class BookingCartProvider with ChangeNotifier {
  final Map<String, EntryTicket> _entryTickets = {};

  List<EntryTicket> get selectedEntryTickets => _entryTickets.values.toList();

  void addTicket(EntryTicket ticket) {
    if (_entryTickets.containsKey(ticket.id)) {
      _entryTickets[ticket.id]!.count++;
    } else {
      ticket.count = 1;
      _entryTickets[ticket.id] = ticket;
    }
    notifyListeners();
  }

  void removeTicket(EntryTicket ticket) {
    if (_entryTickets.containsKey(ticket.id)) {
      if (_entryTickets[ticket.id]!.count > 1) {
        _entryTickets[ticket.id]!.count--;
      } else {
        _entryTickets.remove(ticket.id);
      }
      notifyListeners();
    }
  }

  double get entryTotalAmount  => _entryTickets.values.fold(
    0.0,
    (sum, item) => sum + item.count * item.price,
  );

int get entryTicketPax => selectedEntryTickets.fold(
0,
(sum, ticket) => sum + ticket.count,
);

  final Map<String, ParkingOption> _parkingOptions = {};

  List<ParkingOption> get selectedParking => _parkingOptions.values.toList();

  void addParking(ParkingOption option) {
    if (_parkingOptions.containsKey(option.id)) {
      _parkingOptions[option.id]!.count++;
    } else {
      option.count = 1;
      _parkingOptions[option.id] = option;
    }
    notifyListeners();
  }

  void removeParking(ParkingOption option) {
    if (_parkingOptions.containsKey(option.id)) {
      if (_parkingOptions[option.id]!.count > 1) {
        _parkingOptions[option.id]!.count--;
      } else {
        _parkingOptions.remove(option.id);
      }
      notifyListeners();
    }
  }

  double get parkingTotalAmount => _parkingOptions.values.fold(
    0.0,
    (sum, item) => sum + item.count * item.price,
  );

int get parkingPax => selectedParking.fold(
0,
(sum, parking) => sum + parking.count,
);


final Map<int, Attraction> _selectedAttractions = {};

List<Attraction> get selectedAttractions => _selectedAttractions.values.toList();

void toggleAttraction(Attraction attraction) {
if (_selectedAttractions.containsKey(attraction.id)) {
_selectedAttractions.remove(attraction.id);
} else {
_selectedAttractions[attraction.id] = attraction;
}
notifyListeners();
}

// double get attractionsTotalAmount {
// return _selectedAttractions.values.fold(0.0, (sum, item) => sum + item.priceAdult);
// // This can later be updated to use userType-based price
// }


final Map<String, VisitorSlot> _attractionVisitorSlots = {};

String _attractionKey(int attractionId, UserType type) => '$attractionId-${type.name}';

void incrementAttractionVisitorSlot(int attractionId, UserType type, double price) {
final key = _attractionKey(attractionId, type);
if (_attractionVisitorSlots.containsKey(key)) {
_attractionVisitorSlots[key]!.count++;
} else {
_attractionVisitorSlots[key] = VisitorSlot(
attractionId: attractionId,
type: type,
count: 1,
price: price,
);
}
notifyListeners();
}

void decrementAttractionVisitorSlot(int attractionId, UserType type) {
final key = _attractionKey(attractionId, type);
if (_attractionVisitorSlots.containsKey(key)) {
if (_attractionVisitorSlots[key]!.count > 1) {
_attractionVisitorSlots[key]!.count--;
} else {
_attractionVisitorSlots.remove(key);
}
notifyListeners();
}
}

List<VisitorSlot> get selectedAttractionVisitorSlots => _attractionVisitorSlots.values.toList();

// Returns total number of visitors for a given attraction
int totalPaxForAttraction(int attractionId) {
  return selectedAttractionVisitorSlots
      .where((s) => s.attractionId == attractionId)
      .fold(0, (sum, slot) => sum + slot.count);
}

// Returns total price for a given attraction
double totalAmountForAttraction(int attractionId) {
  return selectedAttractionVisitorSlots
      .where((s) => s.attractionId == attractionId)
      .fold(0.0, (sum, slot) => sum + (slot.count * slot.price));
}

double get visitorAttractionTotalAmount => selectedAttractionVisitorSlots.fold(
0.0, (sum, item) => sum + item.count * item.price);

int get attractionVisitorPax => selectedAttractionVisitorSlots.fold(
0,
(sum, visitor) => sum + visitor.count,
);

final Map<int, Movie> _selectedMovies = {};

List<Movie> get selectedMovies => _selectedMovies.values.toList();

void toggleMovie(Movie movie) {
if (_selectedMovies.containsKey(movie.id)) {
_selectedMovies.remove(movie.id);
} else {
_selectedMovies[movie.id] = movie;
}
notifyListeners();
}

// double get moviesTotalAmount => _selectedMovies.values.fold(
// 0.0, (sum, m) => sum + m.priceAdult); // use userType later

String _movieKey(int movieId, UserType type) => '$movieId-${type.name}';

final Map<String, VisitorSlot> _movieVisitorSlots = {};

void incrementMovieVisitorSlot(int movieId, UserType type, double price) {
final key = _movieKey(movieId, type);
if (_movieVisitorSlots.containsKey(key)) {
_movieVisitorSlots[key]!.count++;
} else {
_movieVisitorSlots[key] = VisitorSlot(
attractionId: movieId,
type: type,
count: 1,
price: price,
);
}
notifyListeners();
}

void decrementMovieVisitorSlot(int movieId, UserType type) {
final key = _movieKey(movieId, type);
if (_movieVisitorSlots.containsKey(key)) {
if (_movieVisitorSlots[key]!.count > 1) {
_movieVisitorSlots[key]!.count--;
} else {
_movieVisitorSlots.remove(key);
}
notifyListeners();
}
}

List<VisitorSlot> get selectedMovieVisitorSlots => _movieVisitorSlots.values.toList();

int totalPaxForMovie(int movieId) {
  return selectedMovieVisitorSlots
      .where((s) => s.attractionId == movieId)
      .fold(0, (sum, slot) => sum + slot.count);
}

double totalAmountForMovie(int movieId) {
  return selectedMovieVisitorSlots
      .where((s) => s.attractionId == movieId)
      .fold(0.0, (sum, slot) => sum + (slot.count * slot.price));
}


double get movieVisitorTotalAmount => selectedMovieVisitorSlots.fold(
0.0,
(sum, item) => sum + item.count * item.price,
);

int get movieVisitorPax => selectedMovieVisitorSlots.fold(
0,
(sum, visitor) => sum + visitor.count,
);

int get totalPax => entryTicketPax + parkingPax + attractionVisitorPax + movieVisitorPax;

double get overallTotalAmount =>
entryTotalAmount + parkingTotalAmount + visitorAttractionTotalAmount + movieVisitorTotalAmount;

}
