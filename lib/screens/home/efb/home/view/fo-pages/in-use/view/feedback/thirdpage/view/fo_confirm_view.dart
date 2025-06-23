// ignore_for_file: camel_case_types, deprecated_member_use

import 'dart:developer';

import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/controller/fo_used_controller.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/thirdpage/controller/fo_confirm_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Fo_Confirm_View extends GetView<Fo_Confirm_Controller> {
  const Fo_Confirm_View({super.key});

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
            'Feedback - Confirm',
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: SizeConstant.SUB_HEADING_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
                            'Bracket (RAM - MOUNT) Integrity',
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
                            'Strong Mechanical Integrity During Flight',
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
                            groupValue: controller.q13.value,
                            onChanged: (value) {
                              controller.q13.value = value.toString();
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
                            groupValue: controller.q13.value,
                            onChanged: (value) {
                              controller.q13.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Easy to use?',
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
                            groupValue: controller.q14.value,
                            onChanged: (value) {
                              controller.q14.value = value.toString();
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
                            groupValue: controller.q14.value,
                            onChanged: (value) {
                              controller.q14.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Easy to detached during emergency, if required',
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
                            groupValue: controller.q15.value,
                            onChanged: (value) {
                              controller.q15.value = value.toString();
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
                            groupValue: controller.q15.value,
                            onChanged: (value) {
                              controller.q15.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Obstruct emergency egress',
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
                            groupValue: controller.q16.value,
                            onChanged: (value) {
                              controller.q16.value = value.toString();
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
                            groupValue: controller.q16.value,
                            onChanged: (value) {
                              controller.q16.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Bracket position obstruct your vision',
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
                            groupValue: controller.q17.value,
                            onChanged: (value) {
                              controller.q17.value = value.toString();
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
                            groupValue: controller.q17.value,
                            onChanged: (value) {
                              controller.q17.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'If Yes, How severe did it obstruct your vision?',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Low',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'Low',
                            groupValue: controller.q18.value,
                            onChanged: (value) {
                              controller.q18.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'High',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: 'High',
                            groupValue: controller.q18.value,
                            onChanged: (value) {
                              controller.q18.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'If high please write down your concern in the comment box below',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConstant.VERTICAL_PADDING,
                            ),
                            child: TextField(
                              controller: controller.q19,
                              cursorColor: ColorConstants.primaryColor,
                              decoration:
                                  CustomInputDecoration.customInputDecoration(
                                    labelText: 'Write here...',
                                  ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              onChanged: ((value) {
                                controller.q19.text = value;
                                log('Writing: $value');
                              }),
                            ),
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
                            'EFB Software Integrity',
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
                            'Airbus Flysmart (Performance)',
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
                            groupValue: controller.q20.value,
                            onChanged: (value) {
                              controller.q20.value = value.toString();
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
                            groupValue: controller.q20.value,
                            onChanged: (value) {
                              controller.q20.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Lido (Navigation)',
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
                            groupValue: controller.q21.value,
                            onChanged: (value) {
                              controller.q21.value = value.toString();
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
                            groupValue: controller.q21.value,
                            onChanged: (value) {
                              controller.q21.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Vistair Docunet (Library Document)',
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
                            groupValue: controller.q22.value,
                            onChanged: (value) {
                              controller.q22.value = value.toString();
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
                            groupValue: controller.q22.value,
                            onChanged: (value) {
                              controller.q22.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          Text(
                            'Additional comment on all observation',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConstant.VERTICAL_PADDING,
                            ),
                            child: TextField(
                              controller: controller.q23,
                              cursorColor: ColorConstants.primaryColor,
                              decoration:
                                  CustomInputDecoration.customInputDecoration(
                                    labelText: 'Write here...',
                                  ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              onChanged: ((value) {
                                controller.q23.text = value;
                              }),
                            ),
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
                        final foInUseController =
                            Get.find<Fo_Used_Controller>();
                        foInUseController.isFeedback.value = true;
                        foInUseController.feedback.value = {
                          'q1': controller.feedbackQuestion['q1'],
                          'q2': controller.feedbackQuestion['q2'],
                          'q3': controller.feedbackQuestion['q3'],
                          'q4': controller.feedbackQuestion['q4'],
                          'q5': controller.feedbackQuestion['q5'],
                          'q6': controller.feedbackQuestion['q6'],
                          'q7': controller.batteryQuestion['q7'],
                          'q8': controller.batteryQuestion['q8'],
                          'q9': controller.batteryQuestion['q9'],
                          'q10': controller.batteryQuestion['q10'],
                          'q11': controller.batteryQuestion['q11'],
                          'q12': controller.batteryQuestion['q12'],
                          'q13': controller.q13.value,
                          'q14': controller.q14.value,
                          'q15': controller.q15.value,
                          'q16': controller.q16.value,
                          'q17': controller.q17.value,
                          'q18': controller.q18.value,
                          'q19': controller.q19.text,
                          'q20': controller.q20.value,
                          'q21': controller.q21.value,
                          'q22': controller.q22.value,
                          'q23': controller.q23.text,
                        };
                        Get.until(
                          (route) =>
                              route.settings.name == AppRoutes.EFB_FO_IN_USE,
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
