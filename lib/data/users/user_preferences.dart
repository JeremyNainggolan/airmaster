import 'dart:developer';
import 'dart:convert';

import 'package:airmaster/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:airmaster/model/users/user.dart';
import 'package:http/http.dart' as http;

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();
  SharedPreferences? _prefs;

  // Private constructor
  UserPreferences._internal();

  // Public factory (singleton)
  factory UserPreferences() {
    return _instance;
  }

  // Inisialisasi prefs
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save User
  Future<bool> saveUser(User user) async {
    await init();
    await _prefs!.setBool('isLogin', true);
    await _prefs!.setString('token', user.token ?? '');
    await _prefs!.setString('token_type', user.token_type ?? '');
    await _prefs!.setString('id_number', user.id_number ?? '');
    await _prefs!.setString('name', user.name ?? '');
    await _prefs!.setString('email', user.email ?? '');
    await _prefs!.setString('hub', user.hub ?? '');
    await _prefs!.setString('status', user.status ?? '');
    await _prefs!.setString('loa_number', user.loa_number ?? '');
    await _prefs!.setString('license_number', user.license_number ?? '');
    await _prefs!.setString(
      'license_expiry',
      user.license_expiry?.toIso8601String() ?? '',
    );
    await _prefs!.setString('rank', user.rank ?? '');
    await _prefs!.setString('instructor', (user.instructor?.join(',') ?? ''));
    return true;
  }

  // Get Full User
  Future<User> getUser() async {
    await init();
    return User(
      isLogin: _prefs!.getBool('isLogin') ?? false,
      token: _prefs!.getString('token') ?? '',
      token_type: _prefs!.getString('token_type') ?? '',
      id_number: _prefs!.getString('id_number') ?? '',
      name: _prefs!.getString('name') ?? '',
      email: _prefs!.getString('email') ?? '',
      hub: _prefs!.getString('hub') ?? '',
      status: _prefs!.getString('status') ?? '',
      loa_number: _prefs!.getString('loa_number') ?? '',
      license_number: _prefs!.getString('license_number') ?? '',
      license_expiry:
          (_prefs!.getString('license_expiry')?.isNotEmpty ?? false)
              ? DateTime.parse(_prefs!.getString('license_expiry')!)
              : null,
      rank: _prefs!.getString('rank') ?? '',
      instructor:
          (_prefs!.getString('instructor')?.split(',') ?? []).cast<String>(),
    );
  }

  // Clear User
  Future<void> clearUser() async {
    await init();
    await _prefs!.remove('isLogin');
    await _prefs!.remove('token');
    await _prefs!.remove('token_type');
    await _prefs!.remove('id_number');
    await _prefs!.remove('name');
    await _prefs!.remove('email');
    await _prefs!.remove('hub');
    await _prefs!.remove('status');
    await _prefs!.remove('loa_number');
    await _prefs!.remove('license_number');
    await _prefs!.remove('license_expiry');
    await _prefs!.remove('rank');
    await _prefs!.remove('instructor');
  }

  Future<bool> isLogin() async {
    await init();
    return _prefs!.getBool('isLogin') ?? false;
  }

  Future<bool> isTokenValid() async {
    await init();
    String email = await getEmail();
    String token = await getToken();

    if (email.isEmpty || token.isEmpty) {
      return false;
    }

    final data = {'email': email, 'token': token};

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.checkToken),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        log("Server error: ${response.body}");
        return false;
      }
    } catch (e) {
      log("Error during login: $e");
      return false;
    }
  }

  // Getters Per Attribute
  Future<String> getToken() async {
    await init();
    return _prefs!.getString('token') ?? '';
  }

  Future<String> getTokenType() async {
    await init();
    return _prefs!.getString('token_type') ?? '';
  }

  Future<String> getIdNumber() async {
    await init();
    return _prefs!.getString('id_number') ?? '';
  }

  Future<String> getName() async {
    await init();
    return _prefs!.getString('name') ?? '';
  }

  Future<String> getEmail() async {
    await init();
    return _prefs!.getString('email') ?? '';
  }

  Future<String> getHub() async {
    await init();
    return _prefs!.getString('hub') ?? '';
  }

  Future<String> getStatus() async {
    await init();
    return _prefs!.getString('status') ?? '';
  }

  Future<String> getLoaNumber() async {
    await init();
    return _prefs!.getString('loa_number') ?? '';
  }

  Future<String> getLicenseNumber() async {
    await init();
    return _prefs!.getString('license_number') ?? '';
  }

  Future<DateTime?> getLicenseExpiry() async {
    await init();
    String? expiryStr = _prefs!.getString('license_expiry');
    if (expiryStr != null && expiryStr.isNotEmpty) {
      return DateTime.parse(expiryStr);
    }
    return null;
  }

  Future<String> getRank() async {
    await init();
    return _prefs!.getString('rank') ?? '';
  }

  Future<List<String>> getInstructor() async {
    await init();
    return (_prefs!.getString('instructor')?.split(',') ?? []).cast<String>();
  }
}
