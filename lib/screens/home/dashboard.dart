import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogo(),
          const SizedBox(height: 50.0),
          _buildWelcomeText(),
          _buildMenuText(),
          const SizedBox(height: 20),
          _buildOption(
            "TS-1",
            "Training Simulator",
            () => Get.toNamed(AppRoutes.TS1_MAIN),
          ),
          const SizedBox(height: 10),
          _buildOption(
            "Training Card",
            "Pilot Training and Proficiency Control Card",
            () => Get.toNamed(AppRoutes.TC_MAIN),
          ),
          const SizedBox(height: 10),
          _buildOption(
            "EFB",
            "Electronic Flight Bag (EFB)",
            () => Get.toNamed(AppRoutes.EFB_MAIN),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() => Center(
    child: Image.asset(
      "assets/images/airasia_logo_text.png",
      color: ColorConstants.backgroundColor,
      scale: 18.0,
    ),
  );

  Widget _buildWelcomeText() => Text(
    "WELCOME",
    style: GoogleFonts.notoSans(
      color: ColorConstants.textSecondary,
      fontSize: 24.0,
      fontWeight: FontWeight.w800,
    ),
  );

  Widget _buildMenuText() => Text(
    "Please select the desired menu",
    style: GoogleFonts.notoSans(
      color: ColorConstants.textSecondary,
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
  );

  Widget _buildOption(String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(
            title,
            style: GoogleFonts.notoSans(
              color: ColorConstants.textPrimary,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.notoSans(
              color: ColorConstants.hintColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: const Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}
