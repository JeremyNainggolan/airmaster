// ignore_for_cell: camel_case_types

// ignore_for_file: camel_case_types, deprecated_member_use

import 'dart:developer';

import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/secondpage/controller/fo_battery_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Fo_Battery_View extends GetView<Fo_Battery_Controller> {
  const Fo_Battery_View({super.key});

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
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorConstants.whiteColor),
            onPressed: () async {
              final confirmed = await ShowAlert.showBackAlert(context);

              if (confirmed == true) {
                Get.back();
              }
            },
          ),
          title: Text(
            "Feedback - Battery Level",
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: SizeConstant.SUB_HEADING_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: ColorConstants.backgroundColor,
        body: SingleChildScrollView(
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
                          'BATTERY LEVEL AFTER ENGINE SHUTDOWN (with or without charging)',
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConstant.VERTICAL_PADDING,
                          ),
                          child: TextField(
                            controller: controller.q7,
                            cursorColor: ColorConstants.primaryColor,
                            decoration:
                                CustomInputDecoration.customInputDecoration(
                                  labelText: 'Sector 1',
                                ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onChanged: ((value) {
                              controller.q7.text = value;
                              log('Sector 1: $value');
                            }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConstant.VERTICAL_PADDING,
                          ),
                          child: TextField(
                            controller: controller.q8,
                            cursorColor: ColorConstants.primaryColor,
                            decoration:
                                CustomInputDecoration.customInputDecoration(
                                  labelText: 'Sector 2',
                                ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onChanged: ((value) {
                              controller.q8.text = value;
                              log('Sector 2: $value');
                            }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConstant.VERTICAL_PADDING,
                          ),
                          child: TextField(
                            controller: controller.q9,
                            cursorColor: ColorConstants.primaryColor,
                            decoration:
                                CustomInputDecoration.customInputDecoration(
                                  labelText: 'Sector 3',
                                ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onChanged: ((value) {
                              controller.q9.text = value;
                              log('Sector 3: $value');
                            }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConstant.VERTICAL_PADDING,
                          ),
                          child: TextField(
                            controller: controller.q10,
                            cursorColor: ColorConstants.primaryColor,
                            decoration:
                                CustomInputDecoration.customInputDecoration(
                                  labelText: 'Sector 4',
                                ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onChanged: ((value) {
                              controller.q10.text = value;
                              log('Sector 4: $value');
                            }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConstant.VERTICAL_PADDING,
                          ),
                          child: TextField(
                            controller: controller.q11,
                            cursorColor: ColorConstants.primaryColor,
                            decoration:
                                CustomInputDecoration.customInputDecoration(
                                  labelText: 'Sector 5',
                                ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onChanged: ((value) {
                              controller.q11.text = value;
                              log('Sector 5: $value');
                            }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConstant.VERTICAL_PADDING,
                          ),
                          child: TextField(
                            controller: controller.q12,
                            cursorColor: ColorConstants.primaryColor,
                            decoration:
                                CustomInputDecoration.customInputDecoration(
                                  labelText: 'Sector 6',
                                ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onChanged: ((value) {
                              controller.q12.text = value;
                              log('Sector 6: $value');
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
                      log(controller.feedbackQuestion.string);
                      Get.toNamed(
                        AppRoutes.EFB_FO_CONFIRM,
                        arguments: {
                          'feedback_question': controller.feedbackQuestion,
                          'battery_question': {
                            'q7': controller.q7.text,
                            'q8': controller.q8.text,
                            'q9': controller.q9.text,
                            'q10': controller.q10.text,
                            'q11': controller.q11.text,
                            'q12': controller.q12.text,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
