// ignore_for_file: camel_case_types, deprecated_member_use
import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/flight_details/controller/flightdetails_assessment_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/helpers/assessment_flight_details_dropdown_item.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:airmaster/helpers/input_decoration.dart';
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
            "Assessment | Flight Details",
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
              child: LoadingAnimationWidget.hexagonDots(
                color: ColorConstants.activeColor,
                size: 48,
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConstant.PADDING),
              child: Form(
                key: controller.formKey,
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
                        Column(
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
                      ],
                    ),

                    Column(
                      children: [
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
                        Column(
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(SizeConstant.PADDING),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () async {
              await controller.getValidation();

              if (controller.formKey.currentState!.validate()) {
                if (controller.firstCandidateIndex <= 2 ||
                    controller.secondCandidateIndex <= 2) {
                  ShowAlert.showInfoAlert(
                    Get.context!,
                    'Caution!',
                    "Please ensure that at least 3 items are selected for each flight crew.",
                  );
                  return;
                } else {
                  await controller.setCandidateAnotated();
                  Get.toNamed(
                    AppRoutes.TS1_EVALUATION,
                    arguments: {
                      'candidate': controller.candidate,
                      'candidateAnotated': controller.candidateAnotated,
                    },
                  );
                }
              } else {
                ShowAlert.showInfoAlert(
                  Get.context!,
                  'Caution!',
                  "Please fill in all the required fields.",
                );
                return;
              }
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
