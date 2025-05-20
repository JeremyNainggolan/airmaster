import 'package:airmaster/routes/app_pages.dart';
import 'package:airmaster/screens/splash.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Airmaster',
      theme: ThemeData(
        primaryColor: ColorConstants.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        fontFamily: GoogleFonts.notoSans().fontFamily,
        colorScheme: ColorScheme(
          primary: ColorConstants.primaryColor,
          secondary: ColorConstants.secondaryColor,
          error: ColorConstants.errorColor,
          surface: ColorConstants.blackColor,
          onPrimary: ColorConstants.primaryColor,
          onSecondary: ColorConstants.secondaryColor,
          onError: ColorConstants.errorColor,
          onSurface: ColorConstants.blackColor,
          brightness: Brightness.light,
        ),
      ),
      home: SplashView(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
