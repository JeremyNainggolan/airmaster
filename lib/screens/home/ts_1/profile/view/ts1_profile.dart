// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/ts_1/profile/controller/ts1_profile_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TS1_Profile extends GetView<TS1_Profile_Controller> {
  const TS1_Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ColorConstants.backgroundColor,
                    borderRadius: BorderRadius.circular(
                      SizeConstant.BORDER_RADIUS,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.shadowColor,
                        blurRadius: 10,
                        spreadRadius: -2,
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(
                        () => Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              height: 200.0,
                              width: 200.0,
                              child:
                                  controller.imgUrl.value.isNotEmpty
                                      ? Image.network(
                                        controller.imgUrl.value,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(Icons.broken_image),
                                        fit: BoxFit.cover,
                                      )
                                      : Image.asset(
                                        'assets/images/airasia_logo_circle.png',
                                        fit: BoxFit.cover,
                                      ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              controller.name.value,
                              style: GoogleFonts.notoSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: ColorConstants.textPrimary,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.rank.value,
                              style: GoogleFonts.notoSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.textPrimary,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.userId.value,
                              style: GoogleFonts.notoSans(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: ColorConstants.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ColorConstants.activeColor,
                    borderRadius: BorderRadius.circular(
                      SizeConstant.BORDER_RADIUS,
                    ),
                    border: Border.all(
                      color: ColorConstants.primaryColor,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.shadowColor,
                        blurRadius: 10,
                        spreadRadius: -2,
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                  ),
                  child: Obx(
                    () => Column(
                      children: [
                        buildRow("Email", controller.email.value),
                        buildRow("Rank", controller.rank.value),
                        buildRow("License No", controller.licenseNumber.value),
                        buildRow("License Expiry", '10/10/2023'),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    ColorConstants.primaryColor,
                  ),
                ),
                child: Text(
                  'Logout',
                  style: GoogleFonts.notoSans(
                    color: ColorConstants.textSecondary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConstants.backgroundColor,
          shadowColor: ColorConstants.shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'Log Out',
            style: GoogleFonts.notoSans(
              color: ColorConstants.textPrimary,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.notoSans(
              color: ColorConstants.textPrimary,
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: GoogleFonts.notoSans(
                  color: ColorConstants.textPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(child: Loading());
                  },
                );

                await controller.logout();
                await Future.delayed(Duration(seconds: 2));

                Get.offAllNamed('/login');
                Get.snackbar(
                  'Logout',
                  'You have been logged out successfully',
                  backgroundColor: ColorConstants.primaryColor,
                  colorText: ColorConstants.textSecondary,
                  duration: const Duration(seconds: 3),
                  snackPosition: SnackPosition.TOP,
                );
              },

              child: Text(
                'Yes',
                style: GoogleFonts.notoSans(
                  color: ColorConstants.primaryColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15.0),
          child: Text(
            label,
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, right: 15.0),
          child: Text(
            value,
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
