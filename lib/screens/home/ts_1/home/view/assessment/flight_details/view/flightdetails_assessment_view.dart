// ignore_for_file: camel_case_types, deprecated_member_use

import 'dart:developer';

import 'package:airmaster/data/asessment/flight_details/flight_details_preferences.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/flight_details/controller/flightdetails_assessment_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/assessment_flight_details_dropdown_item.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:airmaster/widgets/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FlightDetails_View extends GetView<FlightDetails_Controller> {
  const FlightDetails_View({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final bool shouldPop = await _showBackDialog() ?? false;
          if (shouldPop) {
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
              final bool shouldPop = await _showBackDialog() ?? false;
              if (shouldPop) {
                Get.back();
              }
            },
          ),
          title: Text(
            "Assessment | Flight Details",
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: SizeConstant.SUB_HEADING_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: ColorConstants.backgroundColor,
        body: Padding(
          padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CustomDivider(divider: 'Flight Crew 1'),

                      Padding(
                        padding: EdgeInsets.only(
                          bottom: SizeConstant.BOT_PADDING,
                        ),
                        child: DropdownButtonFormField(
                          dropdownColor: ColorConstants.backgroundColor,
                          decoration:
                              CustomInputDecoration.customInputDecoration(
                                labelText: 'Training or Checking Detail',
                              ),
                          items:
                              AssessmentFlightDetailsDropdownItem.getFlightDetailsDropdownItems(
                                ['Training', 'Checking', 'Re - Training'],
                              ),
                          validator: (value) {
                            if (value == null) {
                              return "Select one of the options available";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            controller.firstCandidateAnotated = value!;
                          },
                        ),
                      ),

                      Obx(
                        () => Column(
                          children:
                              controller.firstCandidateAnotatedMap.keys.map<
                                Widget
                              >((item) {
                                return ListTileTheme(
                                  child:
                                      controller.firstCandidateSubAnotatedMap
                                              .containsKey(item)
                                          ? ExpansionTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              item,
                                              style: GoogleFonts.notoSans(
                                                color:
                                                    ColorConstants.textPrimary,
                                                fontSize:
                                                    SizeConstant.TEXT_SIZE_HINT,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            children:
                                                controller.firstCandidateSubAnotatedMap[item]!.entries.map<
                                                  Widget
                                                >((entry) {
                                                  return CheckboxListTile(
                                                    dense: true,
                                                    checkColor:
                                                        ColorConstants
                                                            .whiteColor,
                                                    value: entry.value,
                                                    onChanged: (value) {
                                                      if (value == true) {
                                                        final updatedMap = Map<
                                                          String,
                                                          bool
                                                        >.from(
                                                          controller
                                                              .firstCandidateSubAnotatedMap[item]!,
                                                        ).map(
                                                          (key, val) =>
                                                              MapEntry(
                                                                key,
                                                                false,
                                                              ),
                                                        );

                                                        updatedMap[entry.key] =
                                                            true;

                                                        controller
                                                                .firstCandidateSubAnotatedMap[item] =
                                                            updatedMap;
                                                        controller
                                                            .firstCandidateSubAnotatedMap
                                                            .refresh();
                                                      } else {
                                                        controller
                                                                .firstCandidateSubAnotatedMap[item]![entry
                                                                .key] =
                                                            false;
                                                        controller
                                                            .firstCandidateSubAnotatedMap
                                                            .refresh();
                                                      }
                                                    },
                                                    title: Text(
                                                      entry.key,
                                                      style: GoogleFonts.notoSans(
                                                        color:
                                                            ColorConstants
                                                                .textPrimary,
                                                        fontSize:
                                                            SizeConstant
                                                                .TEXT_SIZE_HINT,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                  );
                                                }).toList(),
                                          )
                                          : item == "Recurrent" ||
                                              item == "Other"
                                          ? ExpansionTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              item,
                                              style: GoogleFonts.notoSans(
                                                color:
                                                    ColorConstants.textPrimary,
                                                fontSize:
                                                    SizeConstant.TEXT_SIZE_HINT,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 50,
                                                  bottom: 20.0,
                                                  top: 10.0,
                                                ),
                                                child: TextFormField(
                                                  decoration:
                                                      CustomInputDecoration.customInputDecoration(
                                                        labelText: "Input",
                                                      ),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter the data';
                                                    }
                                                    return null;
                                                  },
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  onChanged: (value) {
                                                    controller
                                                            .firstCandidateAnotatedMap[item] =
                                                        value;
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                          : CheckboxListTile(
                                            checkColor:
                                                ColorConstants.whiteColor,
                                            dense: true,
                                            value:
                                                controller
                                                    .firstCandidateAnotatedMap[item],
                                            onChanged: (value) {
                                              controller
                                                      .firstCandidateAnotatedMap[item] =
                                                  value!;
                                            },
                                            title: Text(
                                              item,
                                              style: GoogleFonts.notoSans(
                                                color:
                                                    ColorConstants.textPrimary,
                                                fontSize:
                                                    SizeConstant.TEXT_SIZE_HINT,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                          ),
                                );
                              }).toList(),
                        ),
                      ),

                      CustomDivider(divider: 'Flight Crew 2'),

                      Padding(
                        padding: EdgeInsets.only(
                          bottom: SizeConstant.BOT_PADDING,
                        ),
                        child: DropdownButtonFormField(
                          dropdownColor: ColorConstants.backgroundColor,
                          decoration:
                              CustomInputDecoration.customInputDecoration(
                                labelText: 'Training or Checking Detail',
                              ),
                          items:
                              AssessmentFlightDetailsDropdownItem.getFlightDetailsDropdownItems(
                                ['Training', 'Checking', 'Re - Training'],
                              ),
                          validator: (value) {
                            if (value == null) {
                              return "Select one of the options available";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            controller.secondCandidateAnotated = value!;
                          },
                        ),
                      ),

                      Obx(
                        () => Column(
                          children:
                              controller.secondCandidateAnotatedMap.keys.map<
                                Widget
                              >((item) {
                                return ListTileTheme(
                                  child:
                                      controller.secondCandidateSubAnotatedMap
                                              .containsKey(item)
                                          ? ExpansionTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              item,
                                              style: GoogleFonts.notoSans(
                                                color:
                                                    ColorConstants.textPrimary,
                                                fontSize:
                                                    SizeConstant.TEXT_SIZE_HINT,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            children:
                                                controller.secondCandidateSubAnotatedMap[item]!.entries.map<
                                                  Widget
                                                >((entry) {
                                                  return CheckboxListTile(
                                                    dense: true,
                                                    checkColor:
                                                        ColorConstants
                                                            .whiteColor,
                                                    value: entry.value,
                                                    onChanged: (value) {
                                                      if (value == true) {
                                                        final updatedMap = Map<
                                                          String,
                                                          bool
                                                        >.from(
                                                          controller
                                                              .secondCandidateSubAnotatedMap[item]!,
                                                        ).map(
                                                          (key, val) =>
                                                              MapEntry(
                                                                key,
                                                                false,
                                                              ),
                                                        );

                                                        updatedMap[entry.key] =
                                                            true;

                                                        controller
                                                                .secondCandidateSubAnotatedMap[item] =
                                                            updatedMap;
                                                        controller
                                                            .secondCandidateSubAnotatedMap
                                                            .refresh();
                                                      } else {
                                                        controller
                                                                .secondCandidateSubAnotatedMap[item]![entry
                                                                .key] =
                                                            false;
                                                        controller
                                                            .secondCandidateSubAnotatedMap
                                                            .refresh();
                                                      }
                                                    },
                                                    title: Text(
                                                      entry.key,
                                                      style: GoogleFonts.notoSans(
                                                        color:
                                                            ColorConstants
                                                                .textPrimary,
                                                        fontSize:
                                                            SizeConstant
                                                                .TEXT_SIZE_HINT,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                  );
                                                }).toList(),
                                          )
                                          : item == "Recurrent" ||
                                              item == "Other"
                                          ? ExpansionTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              item,
                                              style: GoogleFonts.notoSans(
                                                color:
                                                    ColorConstants.textPrimary,
                                                fontSize:
                                                    SizeConstant.TEXT_SIZE_HINT,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 50,
                                                  bottom: 20.0,
                                                  top: 10.0,
                                                ),
                                                child: TextFormField(
                                                  decoration:
                                                      CustomInputDecoration.customInputDecoration(
                                                        labelText: "Input",
                                                      ),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter the data';
                                                    }
                                                    return null;
                                                  },
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  onChanged: (value) {
                                                    controller
                                                            .secondCandidateAnotatedMap[item] =
                                                        value;
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                          : CheckboxListTile(
                                            checkColor:
                                                ColorConstants.whiteColor,
                                            dense: true,
                                            value:
                                                controller
                                                    .secondCandidateAnotatedMap[item],
                                            onChanged: (value) {
                                              controller
                                                      .secondCandidateAnotatedMap[item] =
                                                  value!;
                                            },
                                            title: Text(
                                              item,
                                              style: GoogleFonts.notoSans(
                                                color:
                                                    ColorConstants.textPrimary,
                                                fontSize:
                                                    SizeConstant.TEXT_SIZE_HINT,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                          ),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConstant.TOP_PADDING),
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.getValidation();

                        if (controller.formKey.currentState!.validate()) {
                          if (controller.firstCandidateIndex <= 2) {
                            showModalBottomSheet(
                              context: Get.context!,
                              backgroundColor: ColorConstants.warningColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Wrap(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            color: ColorConstants.textPrimary,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Warning!",
                                            style: GoogleFonts.notoSans(
                                              fontSize: SizeConstant.TEXT_SIZE,
                                              color: ColorConstants.textPrimary,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                      Text(
                                        "Please select at least 3 items for Flight Crew 1",
                                        style: GoogleFonts.notoSans(
                                          fontSize: SizeConstant.TEXT_SIZE_HINT,
                                          color: ColorConstants.textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else if (controller.secondCandidateIndex <= 2) {
                            showModalBottomSheet(
                              context: Get.context!,
                              backgroundColor: ColorConstants.warningColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Wrap(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            color: ColorConstants.textPrimary,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Warning!",
                                            style: GoogleFonts.notoSans(
                                              fontSize: SizeConstant.TEXT_SIZE,
                                              color: ColorConstants.textPrimary,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                      Text(
                                        "Please select at least 3 items for Flight Crew 2",
                                        style: GoogleFonts.notoSans(
                                          fontSize: SizeConstant.TEXT_SIZE_HINT,
                                          color: ColorConstants.textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            Get.dialog(
                              Center(
                                child: LoadingAnimationWidget.hexagonDots(
                                  color: ColorConstants.primaryColor,
                                  size: 50,
                                ),
                              ),
                            );

                            await controller.candidateAnotated();
                            await Future.delayed(Duration(seconds: 1));

                            Get.toNamed(AppRoutes.TS1_EVALUATION);
                          }
                        } else {
                          showModalBottomSheet(
                            context: Get.context!,
                            backgroundColor: ColorConstants.warningColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Wrap(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.warning_amber_rounded,
                                          color: ColorConstants.textPrimary,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Warning!",
                                          style: GoogleFonts.notoSans(
                                            fontSize: SizeConstant.TEXT_SIZE,
                                            color: ColorConstants.textPrimary,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      "Please fill all the required fields",
                                      style: GoogleFonts.notoSans(
                                        fontSize: SizeConstant.TEXT_SIZE_HINT,
                                        color: ColorConstants.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            SizeConstant.BORDER_RADIUS,
                          ),
                        ),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Next",
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textSecondary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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

  Future<bool?> _showBackDialog() {
    return Get.dialog<bool>(
      AlertDialog(
        backgroundColor: ColorConstants.backgroundColor,
        title: Text(
          'Are you sure?',
          style: GoogleFonts.notoSans(
            color: ColorConstants.textPrimary,
            fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Exiting will discard all changes made to this form and you have to start over.',
          style: GoogleFonts.notoSans(
            color: ColorConstants.textPrimary,
            fontSize: SizeConstant.TEXT_SIZE,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'No',
              style: GoogleFonts.notoSans(
                color: ColorConstants.primaryColor,
                fontSize: SizeConstant.TEXT_SIZE,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: () => Get.back(result: false),
          ),
          TextButton(
            child: Text(
              'Yes',
              style: GoogleFonts.notoSans(
                color: ColorConstants.primaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: () {
              FlightDetailsPreferences().clear();
              Get.back(result: true);
            },
          ),
        ],
      ),
    );
  }
}
