import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRoleProvider with ChangeNotifier {
  String _userRole = ''; // Peran pengguna yang akan disimpan

  String get userRole => _userRole; // Getter untuk peran pengguna

  /*void setUserRole(String role) {
    _userRole = role;
    print('User role set to: $_userRole'); // Print the user role
    notifyListeners(); // Memanggil notifyListeners saat peran pengguna diubah
  }*/
  Future<void> setUserRole(String role) async {
    _userRole = role;
    print('User role set to: $_userRole');
    notifyListeners();

    // Save user role to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRole', _userRole);
  }
}
