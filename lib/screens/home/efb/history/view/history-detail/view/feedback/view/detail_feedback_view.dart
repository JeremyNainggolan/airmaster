import 'dart:developer';

import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/efb/history/view/history-detail/view/feedback/controller/detail_feedback_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/build_row_red_value.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail_Feedback_View extends GetView<Detail_Feedback_Controller> {
  const Detail_Feedback_View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "EFB | History Detail - Feedback",
          style: GoogleFonts.notoSans(
            color: ColorConstants.textSecondary,
            fontSize: SizeConstant.SUB_HEADING_SIZE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorConstants.primaryColor,
            ),
          );
        }

        return SingleChildScrollView(
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
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Battery Integrity',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: ColorConstants.dividerColor,
                          thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Do you charge the device during your duty?', // q1
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q1'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q1'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Do you find any risk or concern on the cabling?', // q2
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q2'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q2'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Divider(
                          color: ColorConstants.dividerColor,
                          thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                        ),
                        Text(
                          'If charging the device is REQUIRED.',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Flight Phase', // q3
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q3'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q3'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Charging duration', // q4
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q4'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q4'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Divider(
                          color: ColorConstants.dividerColor,
                          thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                        ),
                        Text(
                          'If charging the device is NOT REQUIRED.',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Did you utilize ALL EFB software during your duty?', // q5
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q5'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q5'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Which software did you utilize the most?', // q6
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q6'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q6'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),

                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.tertiaryColor,
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
                          'BATTERY LEVEL AFTER ENGINE SHUTDOWN (with or without charging)',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: ColorConstants.dividerColor,
                          thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                        ),
                        BuildRowRedValue(
                          label: '1st Sector',
                          value:
                              controller.feedback['q7'].toString().isEmpty
                                  ? '-'
                                  : controller.feedback['q7'],
                        ),
                        BuildRowRedValue(
                          label: '2nd Sector',
                          value:
                              controller.feedback['q8'].toString().isEmpty
                                  ? '-'
                                  : controller.feedback['q8'],
                        ),
                        BuildRowRedValue(
                          label: '3rd Sector',
                          value:
                              controller.feedback['q9'].toString().isEmpty
                                  ? '-'
                                  : controller.feedback['q9'],
                        ),
                        BuildRowRedValue(
                          label: '4th Sector',
                          value:
                              controller.feedback['q10'].toString().isEmpty
                                  ? '-'
                                  : controller.feedback['q10'],
                        ),
                        BuildRowRedValue(
                          label: '5th Sector',
                          value:
                              controller.feedback['q11'].toString().isEmpty
                                  ? '-'
                                  : controller.feedback['q11'],
                        ),
                        BuildRowRedValue(
                          label: '6th Sector',
                          value:
                              controller.feedback['q12'].toString().isEmpty
                                  ? '-'
                                  : controller.feedback['q12'],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),

                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.tertiaryColor,
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
                          'Bracket (RAM - MOUNT) Integrity',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: ColorConstants.dividerColor,
                          thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Strong Mechanical Integrity During Flight', // q13
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q13'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q13'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Easy to use?', // q14
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q14'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q14'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Easy to detached during emergency, if required', // q15
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q15'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q15'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Obstruct emergency egress', // q16
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q16'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q16'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Bracket position obstruct your vision', // q17
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q17'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q17'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'If Yes, How severe did it obstruct your vision?', // q18
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q18'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q18'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'If high please write down your concern in the comment box below', // q19
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q19'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q19'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.tertiaryColor,
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
                          'EFB Software Integrity',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: ColorConstants.dividerColor,
                          thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Airbus Flysmart (Performance)', // q20
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q20'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q20'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Lido (Navigation)', // q21
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q21'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q21'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'Vistair Docunet (Library Document)', // q22
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          controller.feedback['q22'].toString().isEmpty
                              ? '-'
                              : controller.feedback['q22'],
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textTertiary,
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
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.tertiaryColor,
                    borderRadius: BorderRadius.circular(
                      SizeConstant.BORDER_RADIUS,
                    ),
                    border: Border.all(color: ColorConstants.blackColor),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Additional comment on all observation', // q23
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              controller.feedback['q23'].toString().isEmpty
                                  ? '-'
                                  : controller.feedback['q23'],
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textTertiary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConstant.VERTICAL_PADDING,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.successColor,
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () async {
                ShowAlert.showLoadingAlert(Get.context!, 'Please wait...');

                await Future.delayed(Duration(seconds: 2));

                final isSuccess = await controller.createDocument();

                if (isSuccess == true) {
                  Get.back();
                } else {
                  ShowAlert.showErrorAlert(
                    Get.context!,
                    'Failed to create document',
                    'Please try again later.',
                  );
                }
              },
              child: Text(
                'Open Attachment Feedback',
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.EFB_HISTORY_DETAIL_FORMAT_PDF);
        },
        child: Icon(Icons.edit, size: 38.0, color: ColorConstants.whiteColor),
      ),
    );
  }
}
