// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/profile/controller/tc_profile_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TC_Profile extends GetView<TC_Profile_Controller> {
  const TC_Profile({super.key});

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: Container(
                              height: 200.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26, // Warna shadow
                                    blurRadius: 10,        // Seberapa blur shadow-nya
                                    spreadRadius: 4,       // Seberapa lebar shadow menyebar
                                    offset: Offset(0, 4),  // Posisi shadow (x, y)
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: controller.imgUrl.value.isNotEmpty
                                    ? Image.network(
                                        controller.imgUrl.value,
                                        errorBuilder: (context, error, stackTrace) =>
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
                      ),

                      const SizedBox(height: SizeConstant.SPACING), 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              controller.name.value,
                              style: GoogleFonts.notoSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: ColorConstants.textPrimary,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Text(
                                  controller.rank.value,
                                  style: GoogleFonts.notoSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.hintColor,
                                  ),
                                ),
                              ),
                              Obx(
                                () => Text(
                                  ' | ${controller.userId.value}',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.hintColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: SizeConstant.SPACING),

                          Table(
                            columnWidths: {
                              0: IntrinsicColumnWidth(),
                              1: FixedColumnWidth(10),
                              2: FlexColumnWidth(),
                            },
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: [
                              buildReactiveRow('Email', controller.email),
                              buildReactiveRow('Hub', controller.hub),
                              buildReactiveRow('License Number', controller.licenseNumber),
                              buildReactiveRow('License Expiry', controller.licenseExpiry),
                            ],
                          ),
                          
                        ],
                      ),
                    ],
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

TableRow buildReactiveRow(String label, RxString valueRx) {

  TextStyle labelTextStyle = GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ColorConstants.labelColor,
  );

  TextStyle valueTextStyle = GoogleFonts.notoSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ColorConstants.valueColor,
  );
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10.0 , right: 10.0, bottom: 5.0),
        child: Text(label, style: labelTextStyle),
      ),
      Text(':', style: labelTextStyle),
      Obx(() => Text(valueRx.value, style: valueTextStyle)),
    ],
  );
}

}
