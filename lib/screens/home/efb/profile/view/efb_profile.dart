// ignore_for_file: camel_case_types

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/efb/profile/controller/efb_profile_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:airmaster/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/quickalert.dart';

class EFB_Profile extends GetView<EFB_Profile_Controller> {
  const EFB_Profile({super.key});

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
                padding: EdgeInsets.only(bottom: SizeConstant.BOT_PADDING),
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
                        () => Padding(
                          padding: EdgeInsets.only(
                            top: SizeConstant.TOP_PADDING_MAX,
                          ),
                          child: Center(
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
                                          'assets/images/default_picture.png',
                                          fit: BoxFit.cover,
                                        ),
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
                              "Rank: ${controller.rank.value} | ID: ${controller.userId.value}",
                              style: GoogleFonts.notoSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.textPrimary,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: SizeConstant.TOP_PADDING_MAX,
                            ),
                            child: TextButton(
                              onPressed: () => {showBottomDialog()},
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all(
                                  EdgeInsets.all(SizeConstant.SCREEN_PADDING),
                                ),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      SizeConstant.BORDER_RADIUS,
                                    ),
                                  ),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.qr_code_scanner,
                                    color: ColorConstants.blackColor,
                                    size: 100.0,
                                  ),
                                  Text(
                                    'Click to view QR Code',
                                    style: GoogleFonts.notoSans(
                                      color: ColorConstants.textPrimary,
                                      fontSize: SizeConstant.TEXT_SIZE_HINT,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
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
                padding: const EdgeInsets.only(
                  bottom: SizeConstant.BOT_PADDING,
                ),
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
                  child: Column(
                    children: [
                      Obx(() => buildRow("Email", controller.email.value)),
                      Obx(() => buildRow("Status", controller.status.value)),
                      Obx(() => buildRow("Hub", controller.hub.value)),
                      Obx(
                        () => buildRow(
                          "License Number",
                          controller.licenseNumber.value,
                        ),
                      ),
                      Obx(
                        () => buildRow(
                          "License Expiry",
                          controller.licenseExpiry.value != null
                              ? DateFormatter.convertDateTimeDisplay(
                                controller.licenseExpiry.value.toString(),
                                'dd MMMM yyyy',
                              )
                              : 'N/A',
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  QuickAlert.show(
                    context: Get.context!,
                    barrierDismissible: false,
                    type: QuickAlertType.confirm,
                    title: 'Log Out',
                    confirmBtnTextStyle: GoogleFonts.notoSans(
                      color: ColorConstants.textSecondary,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    cancelBtnTextStyle: GoogleFonts.notoSans(
                      color: ColorConstants.textPrimary,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    text: 'Are you sure you want to log out?',
                    confirmBtnText: 'Yes',
                    cancelBtnText: 'No',
                    onConfirmBtnTap: () async {
                      await controller.logout();
                      Get.offAllNamed(AppRoutes.LOGIN_SCREEN);
                    },
                    onCancelBtnTap: () {
                      Get.back();
                    },
                  );
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
                  'Sign Out',
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

  Widget generateQRCode() {
    final idNo = controller.userId.value;

    return QrImageView(
      data: idNo,
      version: QrVersions.auto,
      size: 600.0,
      foregroundColor: Colors.black,
    );
  }

  Widget addAirAsiaLogoToQRCode() {
    return Container(
      width: 180.0,
      height: 180.0,
      child: Stack(
        children: [
          generateQRCode(),
          Center(
            child: Image.asset(
              'assets/images/airasia_logo_circle.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }

  void showBottomDialog() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: Get.width,
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: ColorConstants.whiteColor,
            ),
            child: Column(
              children: [
                Text(
                  "QR Code",
                  style: GoogleFonts.notoSans(
                    fontSize: SizeConstant.TEXT_SIZE,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textPrimary,
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                addAirAsiaLogoToQRCode(),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                Text(
                  "SCAN ME",
                  style: GoogleFonts.notoSans(
                    fontSize: SizeConstant.TEXT_SIZE_HINT,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textTertiary,
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_DOUBLE),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showLogoutDialog(BuildContext context) async {
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
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
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

                Get.offAllNamed(AppRoutes.LOGIN_SCREEN);
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
                  color: ColorConstants.textSecondary,
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
