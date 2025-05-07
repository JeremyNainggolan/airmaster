import 'dart:async';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _checkingLogin = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    setState(() {
      _checkingLogin = true;
    });

    final isLogin = await UserPreferences().isLogin();
    final isTokenValid = await UserPreferences().isTokenValid();

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _checkingLogin = false;
    });

    final targetRoute =
        (isLogin && isTokenValid)
            ? AppRoutes.MAIN_SCREEN
            : AppRoutes.LOGIN_SCREEN;

    Get.offAllNamed(targetRoute);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFFFFFF),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Center(
              child: Image.asset(
                'assets/images/airasia_logo_circle.png',
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),
            if (_checkingLogin)
              LoadingAnimationWidget.flickr(
                leftDotColor: ColorConstants.primaryColor,
                rightDotColor: ColorConstants.secondaryColor,
                size: 40.0,
              )
            else
              const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
