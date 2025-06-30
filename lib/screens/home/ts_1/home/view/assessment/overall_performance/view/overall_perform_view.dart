// ignore_for_file: deprecated_member_use

import 'package:airmaster/helpers/input_decoration.dart';
import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/overall_performance/controller/overall_perfom_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Overall_Perform_View extends GetView<Overall_Perfom_Controller> {
  const Overall_Perform_View({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final shouldPop = await ShowAlert.showBackAlert(Get.context!);

          if (shouldPop == true) {
            Get.back();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
            onPressed: () async {
              final shouldPop = await ShowAlert.showBackAlert(Get.context!);

              if (shouldPop == true) {
                Get.back();
              }
            },
          ),
          title: Text(
            "Assessment | Overall Performance",
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: SizeConstant.SUB_HEADING_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: ColorConstants.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstant.SCREEN_PADDING,
          ),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CustomDivider(divider: 'First Crew Performance'),
                      DropdownButtonFormField<String>(
                        value:
                            controller.firstCrewPerformance.value.isEmpty
                                ? null
                                : controller.firstCrewPerformance.value,
                        decoration: CustomInputDecoration.customInputDecoration(
                          labelText: 'Overall Performance',
                        ),
                        dropdownColor: ColorConstants.backgroundColor,
                        items:
                            controller.performanceList
                                .map(
                                  (perf) => DropdownMenuItem<String>(
                                    value: perf,
                                    child: Text(
                                      perf,
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.textPrimary,
                                        fontSize: SizeConstant.TEXT_SIZE_HINT,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          controller.firstCrewPerformance.value = value!;
                        },
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      DropdownButtonFormField<String>(
                        value:
                            controller.firstCrewRecommendation.value.isEmpty
                                ? null
                                : controller.firstCrewRecommendation.value,
                        decoration: CustomInputDecoration.customInputDecoration(
                          labelText: "Instructor's Recommendation",
                        ),
                        dropdownColor: ColorConstants.backgroundColor,
                        items:
                            controller.recomendationList
                                .map(
                                  (rec) => DropdownMenuItem<String>(
                                    value: rec,
                                    child: Text(
                                      rec,
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.textPrimary,
                                        fontSize: SizeConstant.TEXT_SIZE_HINT,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          controller.firstCrewRecommendation.value = value!;
                        },
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      TextField(
                        controller: controller.firstCrewNotes,
                        maxLines: 5,
                        decoration: CustomInputDecoration.customInputDecoration(
                          labelText: 'Notes',
                        ),
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.whiteColor,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(
                              color: ColorConstants.blackColor,
                              width: 1.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "See other Instructor's Notes",
                            style: GoogleFonts.notoSans(
                              fontStyle: FontStyle.italic,
                              color: ColorConstants.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConstant.TEXT_SIZE_HINT,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomDivider(divider: 'Second Crew Performance'),
                      DropdownButtonFormField<String>(
                        value:
                            controller.secondCrewPerformance.value.isEmpty
                                ? null
                                : controller.secondCrewPerformance.value,
                        decoration: CustomInputDecoration.customInputDecoration(
                          labelText: 'Overall Performance',
                        ),
                        dropdownColor: ColorConstants.backgroundColor,
                        items:
                            controller.performanceList
                                .map(
                                  (perf) => DropdownMenuItem<String>(
                                    value: perf,
                                    child: Text(
                                      perf,
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.textPrimary,
                                        fontSize: SizeConstant.TEXT_SIZE_HINT,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          controller.secondCrewPerformance.value = value!;
                        },
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      DropdownButtonFormField<String>(
                        value:
                            controller.secondCrewRecommendation.value.isEmpty
                                ? null
                                : controller.secondCrewRecommendation.value,
                        decoration: CustomInputDecoration.customInputDecoration(
                          labelText: "Instructor's Recommendation",
                        ),
                        dropdownColor: ColorConstants.backgroundColor,
                        items:
                            controller.recomendationList
                                .map(
                                  (rec) => DropdownMenuItem<String>(
                                    value: rec,
                                    child: Text(
                                      rec,
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.textPrimary,
                                        fontSize: SizeConstant.TEXT_SIZE_HINT,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          controller.secondCrewRecommendation.value = value!;
                        },
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      TextField(
                        controller: controller.firstCrewNotes,
                        maxLines: 5,
                        decoration: CustomInputDecoration.customInputDecoration(
                          labelText: 'Notes',
                        ),
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.whiteColor,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(
                              color: ColorConstants.blackColor,
                              width: 1.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "See other Instructor's Notes",
                            style: GoogleFonts.notoSans(
                              fontStyle: FontStyle.italic,
                              color: ColorConstants.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConstant.TEXT_SIZE_HINT,
                            ),
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
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(SizeConstant.PADDING),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () async {
              Get.toNamed(AppRoutes.TS1_DECLARATION);
            },
            child: Text(
              'Next',
              style: GoogleFonts.notoSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
