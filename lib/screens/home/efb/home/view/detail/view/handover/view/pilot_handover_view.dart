// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:airmaster/helpers/qr_scanner.dart';
import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/handover/controller/pilot_handover_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Pilot_Handover_View extends GetView<Pilot_Handover_Controller> {
  const Pilot_Handover_View({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final confirmed = await ShowAlert.showBackAlert(context);

        if (confirmed == true) {
          Get.back();
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          leading: IconButton(
            onPressed: () async {
              final confirmed = await ShowAlert.showBackAlert(context);

              if (confirmed == true) {
                Get.back();
              }
            },
            icon: Icon(Icons.arrow_back, color: ColorConstants.whiteColor),
          ),
          title: Text(
            'EFB | Pilot Handover',
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: SizeConstant.SUB_HEADING_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.whiteColor,
                    borderRadius: BorderRadius.circular(
                      SizeConstant.BORDER_RADIUS,
                    ),
                    border: Border.all(color: ColorConstants.blackColor),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Note:',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'You must be in one place with the next FO to confirm the return. If you are in a different place, whatever the FO contains, you automatically agree with its statement.',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.primaryColor,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primaryColor,
                    ),
                    onPressed: () async {
                      final result = await Get.to(() => QrScanner());

                      if (result != null) {
                        log('QR Code Result: $result');
                      }
                    },
                    child: Text(
                      'Scan QR Crew',
                      style: GoogleFonts.notoSans(
                        color: ColorConstants.textSecondary,
                        fontSize: SizeConstant.TEXT_SIZE,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
