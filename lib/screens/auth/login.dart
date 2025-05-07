import 'dart:developer';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/screens/home/dashboard.dart';
import 'package:airmaster/services/auth/auth_service.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: ColorConstants.backgroundColor,
        child: _isLoading ? Center(child: Loading()) : _buildLoginContent(),
      ),
    );
  }

  Widget _buildLoginContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage('assets/images/airasia_logo_circle.png'),
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        const SizedBox(height: 35.0),
        Text(
          'Hi there, Welcome Back!',
          style: GoogleFonts.notoSans(
            color: ColorConstants.textPrimary,
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          'Please login to your account',
          style: GoogleFonts.notoSans(
            color: ColorConstants.hintColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 50.0),
        ElevatedButton(
          onPressed: signIn,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
            ),
            backgroundColor: WidgetStateProperty.all(
              ColorConstants.primaryColor,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                FontAwesomeIcons.google,
                color: Colors.white,
                size: 18.0,
              ),
              const SizedBox(width: 10.0),
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
    );
  }

  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await AuthService.login();
      if (user != false) {
        final userPrefs = UserPreferences();
        final String name = await userPrefs.getName();
        _showWelcomeSnackBar(name.isNotEmpty ? name : "Guest");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      } else {
        _showErrorSnackBar(
          "Your account is not registered, Please contact your IT Support",
        );
      }
    } catch (e) {
      log(e.toString());
      _showErrorSnackBar("Please contact your IT Support");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showWelcomeSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Welcome, $message"),
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

  void _showErrorSnackBar(String message) {
    log("Error: $message");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $message"),
        duration: const Duration(milliseconds: 5000),
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
