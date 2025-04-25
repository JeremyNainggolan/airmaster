import 'dart:developer';
import 'package:airmaster/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: ColorConstants.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/airasia_logo_circle.png'),
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            SizedBox(height: 35.0),
            Text(
              'Hi there, Welcome Back!',
              style: GoogleFonts.notoSans(
                color: ColorConstants.textPrimary,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Please login to your account',
              style: GoogleFonts.notoSans(
                color: ColorConstants.hintColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: signIn,
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
                ),
                backgroundColor: WidgetStateProperty.all(
                  ColorConstants.primaryColor,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                    size: 18.0,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Sign in with Google',
                    style: GoogleFonts.notoSans(
                      color: ColorConstants.textSecondary,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    await AuthService.login();
  }

  void _showWelcomeSnackBar(GoogleSignInAccount user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Welcome, ${user.displayName}"),
        duration: const Duration(milliseconds: 3000),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _showErrorSnackBar(String errorMessage) {
    log("Error: $errorMessage");
    Fluttertoast.showToast(msg: "Error: $errorMessage");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $errorMessage"),
        duration: const Duration(milliseconds: 3000),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
