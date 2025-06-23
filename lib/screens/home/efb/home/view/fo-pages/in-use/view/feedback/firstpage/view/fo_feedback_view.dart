// ignore_for_file: deprecated_member_use

import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/firstpage/controller/fo_feedback_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Fo_Feedback_View extends GetView<Fo_Feedback_Controller> {
  const Fo_Feedback_View({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: ((didPop) async {
        if (didPop) return;
        final confirmed = await ShowAlert.showBackAlert(context);

        if (confirmed == true) {
          Get.back();
        }
      }),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
            onPressed: () async {
              final confirmed = await ShowAlert.showBackAlert(context);

              if (confirmed == true) {
                Get.back();
              }
            },
          ),
          title: Text(
            "Feedback - Battery Integrity",
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: SizeConstant.SUB_HEADING_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: ColorConstants.backgroundColor,
        body: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.tertiaryColor,
                      borderRadius: BorderRadius.circular(
                        SizeConstant.BORDER_RADIUS,
                      ),
                      border: Border.all(color: ColorConstants.blackColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Battery Integrity',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textTertiary,
                              fontSize: SizeConstant.SUB_HEADING_SIZE,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Divider(
                            color: ColorConstants.dividerColor,
                            thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Do you charge the device during your duty?',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Yes',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'Yes',
                            groupValue: controller.q1.value,
                            onChanged: (value) {
                              controller.q1.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'No',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'No',
                            groupValue: controller.q1.value,
                            onChanged: (value) {
                              controller.q1.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Do you find any risk or concern on the cabling?',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Yes',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'Yes',
                            groupValue: controller.q2.value,
                            onChanged: (value) {
                              controller.q2.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'No',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'No',
                            groupValue: controller.q2.value,
                            onChanged: (value) {
                              controller.q2.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.tertiaryColor,
                      borderRadius: BorderRadius.circular(
                        SizeConstant.BORDER_RADIUS,
                      ),
                      border: Border.all(color: ColorConstants.blackColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'If charging the device is REQUIRED.',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textTertiary,
                              fontSize: SizeConstant.SUB_HEADING_SIZE,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Divider(
                            color: ColorConstants.dividerColor,
                            thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Flight Phase',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Cruise',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'Cruise',
                            groupValue: controller.q3.value,
                            onChanged: (value) {
                              controller.q3.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Transit',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'Transit',
                            groupValue: controller.q3.value,
                            onChanged: (value) {
                              controller.q3.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Charging duration',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RadioListTile<String>(
                            title: Text(
                              '0 - 20 minutes',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: '0 - 20 minutes',
                            groupValue: controller.q4.value,
                            onChanged: (value) {
                              controller.q4.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              '21 - 40 minutes',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: '21 - 40 minutes',
                            groupValue: controller.q4.value,
                            onChanged: (value) {
                              controller.q4.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              '41 - 60 minutes',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: '41 - 60 minutes',
                            groupValue: controller.q4.value,
                            onChanged: (value) {
                              controller.q4.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              '61 - 80 minutes',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: '61 - 80 minutes',
                            groupValue: controller.q4.value,
                            onChanged: (value) {
                              controller.q4.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              '81 - 100 minutes',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: '81 - 100 minutes',
                            groupValue: controller.q4.value,
                            onChanged: (value) {
                              controller.q4.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              '101 - 120 minutes',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: '101 - 120 minutes',
                            groupValue: controller.q4.value,
                            onChanged: (value) {
                              controller.q4.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.tertiaryColor,
                      borderRadius: BorderRadius.circular(
                        SizeConstant.BORDER_RADIUS,
                      ),
                      border: Border.all(color: ColorConstants.blackColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'If charging the device is NOT REQUIRED.',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textTertiary,
                              fontSize: SizeConstant.SUB_HEADING_SIZE,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Divider(
                            color: ColorConstants.dividerColor,
                            thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Did you utilize ALL EFB software during your duty?',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Yes',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'Yes',
                            groupValue: controller.q5.value,
                            onChanged: (value) {
                              controller.q5.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'No',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'No',
                            groupValue: controller.q5.value,
                            onChanged: (value) {
                              controller.q5.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Which software did you utilize the most?',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Flysmart',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'Flysmart',
                            groupValue: controller.q6.value,
                            onChanged: (value) {
                              controller.q6.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Lido',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'Lido',
                            groupValue: controller.q6.value,
                            onChanged: (value) {
                              controller.q6.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Docunet',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'Docunet',
                            groupValue: controller.q6.value,
                            onChanged: (value) {
                              controller.q6.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.toNamed(
                          AppRoutes.EFB_FO_BATTERY,
                          arguments: {
                            'feedback_question': {
                              'q1': controller.q1.value,
                              'q2': controller.q2.value,
                              'q3': controller.q3.value,
                              'q4': controller.q4.value,
                              'q5': controller.q5.value,
                              'q6': controller.q6.value,
                            },
                          },
                        );
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        backgroundColor: WidgetStateProperty.all(
                          ColorConstants.primaryColor,
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textSecondary,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
