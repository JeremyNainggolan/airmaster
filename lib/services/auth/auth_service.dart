import 'dart:developer';
import 'dart:convert';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/model/users/user.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  static final _googleSignIn = GoogleSignIn();

  static Future<bool?> login() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        return false;
      }

      GoogleSignInAuthentication auth = await account.authentication;

      final data = {
        'email': account.email,
        'name': account.displayName,
        'id': account.id,
        'photo_url': account.photoUrl,
        'idToken': auth.idToken,
        'accessToken': auth.accessToken,
      };

      final response = await http.post(
        Uri.parse(ApiConfig.loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var userData = responseData['data'];

        User authUser = User.fromJson(userData['user']);

        await UserPreferences().saveUser(authUser);

        // log("Login success: ${response.body}");
        return true;
      } else {
        // log("Server error: ${response.body}");
        return false;
      }
    } catch (e) {
      log("Error during login: $e");
      return false;
    }
  }
}
