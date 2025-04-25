import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static final _googleSignIn = GoogleSignIn();

  static Future login() async {
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

      // Send POST request to your server
      final response = await http.post(
        Uri.parse(ApiConfig.loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      // Handle the response
      if (response.statusCode == 200) {
        log("Login success: ${response.body}");
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
}
