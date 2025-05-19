import 'package:airmaster/model/users/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    isLogin: false,
    token: '',
    token_type: '',
    id_number: '',
    name: '',
    email: '',
    hub: '',
    photo_url: '',
    status: '',
    loa_number: '',
    license_number: '',
    license_expiry: DateTime.now(),
    rank: '',
    instructor: [],
  );

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
