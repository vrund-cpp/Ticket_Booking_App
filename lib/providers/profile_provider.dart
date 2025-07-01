import 'package:flutter/material.dart';
import '../models/booking_history.dart';
import '../models/user.dart';
import '../core/services/api_service.dart';

class ProfileProvider with ChangeNotifier {
bool isEdit = false;
bool isLoaded = false;


User? _user;
List<BookingHistory> bookings = [];

final nameCtrl = TextEditingController();
final emailCtrl = TextEditingController();
final mobileCtrl = TextEditingController();

  User? get user => _user;

void toggleEdit() {
  isEdit = !isEdit;
notifyListeners();
}


Future<void> fetchProfileData() async {
  try{final result = await ApiService.getProfile();
_user = result['user'];
bookings = result['bookings'];
nameCtrl.text = _user?.name?? '';
emailCtrl.text = _user?.email?? '';
mobileCtrl.text = _user?.mobile?? '';
isLoaded  = true;
notifyListeners();}
catch (e) {
    isLoaded  = false;
    debugPrint('❌ Failed to load profile: $e');
}

}



Future<void> saveProfileChanges() async {
 final success = await ApiService.updateProfile(nameCtrl.text, emailCtrl.text, mobileCtrl.text);
  if (success) {
    isLoaded = false;
    await fetchProfileData(); // Refresh from backend
    toggleEdit();
  } else {
    debugPrint('❌ Failed to update profile on server');
    // Optionally show a SnackBar or dialog
  }
}
}