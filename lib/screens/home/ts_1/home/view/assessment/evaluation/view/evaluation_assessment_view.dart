// ignore_for_file: camel_case_types, deprecated_member_use

import 'dart:developer';

import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/evaluation/controller/evaluation_assessment_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:airmaster/helpers/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Evaluation_View extends GetView<Evaluation_Controller> {
  const Evaluation_View({super.key});

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
            "Assessment | Evaluation",
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
                color: ColorConstants.primaryColor,
                size: 48,
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConstant.SCREEN_PADDING,
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CustomDivider(divider: 'Main Assessment'),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConstant.HORIZONTAL_PADDING,
                          ),
                          child: Column(children: _buildEvaluationAssessment()),
                        ),

                        CustomDivider(divider: 'Human Factor Assessment'),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConstant.HORIZONTAL_PADDING,
                          ),
                          child: Column(
                            children: _buildHumanFactorAssessment(),
                          ),
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
              if (controller.formKey.currentState!.validate()) {
                await controller.setEvaluation();
                Get.toNamed(
                  AppRoutes.TS1_OVERALL_PERFORMANCE,
                  arguments: {
                    'candidate': controller.candidate,
                    'candidateAnotated': controller.candidateAnotated,
                    'evaluation': controller.evaluation,
                  },
                );
              } else {
                ShowAlert.showInfoAlert(
                  Get.context!,
                  'Caution!',
                  "Please fill in all the required fields.",
                );
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

  List<Widget> _buildEvaluationAssessment() {
    List<Widget> widgets = [];

    controller.mainEvaluationData.forEach((mainKey, subMap) {
      List<Widget> childrenWidgets = [];

      if (subMap is Map && subMap.keys.every((k) => k is String)) {
        childrenWidgets =
            subMap.keys.map<Widget>((subKey) {
              return Obx(
                () => Padding(
                  padding: EdgeInsets.all(SizeConstant.PADDING),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subKey,
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConstant.TEXT_SIZE,
                        ),
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      Text(
                        "Crew 1",
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: SizeConstant.TEXT_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          if (mainKey.toString() ==
                                  'Aircraft Systems/Procedure' ||
                              mainKey.toString() ==
                                  'Abnormal/Emergency Procedure')
                            Expanded(
                              child: Column(
                                children: [
                                  if (!controller
                                      .firstCrewMainEvaluationData[mainKey][subKey]['not_assigned'])
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: SizeConstant.PADDING,
                                      ),
                                      child: TextFormField(
                                        focusNode: FocusNode(),
                                        decoration:
                                            CustomInputDecoration.customInputDecoration(
                                              labelText: 'Subject',
                                            ),
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a subject';
                                          }
                                          return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          final oldSubMap = Map<
                                            String,
                                            dynamic
                                          >.from(
                                            controller
                                                .firstCrewMainEvaluationData[mainKey][subKey],
                                          );

                                          oldSubMap['subject'] = value;
                                          log(oldSubMap.toString());

                                          final updatedMainMap = Map<
                                            String,
                                            dynamic
                                          >.from(
                                            controller
                                                .firstCrewMainEvaluationData[mainKey],
                                          );

                                          updatedMainMap[subKey] = oldSubMap;

                                          controller
                                                  .firstCrewMainEvaluationData[mainKey] =
                                              updatedMainMap;

                                          controller.firstCrewMainEvaluationData
                                              .refresh();
                                        },
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        checkColor: ColorConstants.whiteColor,
                                        value:
                                            controller
                                                .firstCrewMainEvaluationData[mainKey][subKey]['not_assigned'],
                                        onChanged: (val) {
                                          log('Else:  ${mainKey.toString()}');
                                          final oldSubMap = Map<
                                            String,
                                            dynamic
                                          >.from(
                                            controller
                                                .firstCrewMainEvaluationData[mainKey][subKey],
                                          );

                                          oldSubMap['not_assigned'] = val!;
                                          oldSubMap['PF'] = "";
                                          oldSubMap['PM'] = "";
                                          oldSubMap['subject'] = "";

                                          final updatedMainMap = Map<
                                            String,
                                            dynamic
                                          >.from(
                                            controller
                                                .firstCrewMainEvaluationData[mainKey],
                                          );

                                          updatedMainMap[subKey] = oldSubMap;

                                          controller
                                                  .firstCrewMainEvaluationData[mainKey] =
                                              updatedMainMap;

                                          controller.firstCrewMainEvaluationData
                                              .refresh();
                                        },
                                      ),
                                      Text(
                                        "N/A",
                                        style: GoogleFonts.notoSans(
                                          color: ColorConstants.textPrimary,
                                          fontSize: SizeConstant.TEXT_SIZE,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConstant.SIZED_BOX_WIDTH,
                                      ),
                                      if (!controller
                                          .firstCrewMainEvaluationData[mainKey][subKey]['not_assigned']) ...[
                                        Expanded(
                                          child: DropdownButtonFormField<
                                            String
                                          >(
                                            validator: (value) {
                                              if (value == null) {
                                                return "Please select a value";
                                              }
                                              return null;
                                            },
                                            dropdownColor:
                                                ColorConstants.backgroundColor,
                                            value: null,
                                            items:
                                                ["1", "2", "3", "4", "5"]
                                                    .map(
                                                      (e) => DropdownMenuItem(
                                                        value: e,
                                                        child: Text(
                                                          e,
                                                          style: GoogleFonts.notoSans(
                                                            color:
                                                                ColorConstants
                                                                    .textPrimary,
                                                            fontSize:
                                                                SizeConstant
                                                                    .TEXT_SIZE_HINT,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                            onChanged: (value) {
                                              final oldSubMap = Map<
                                                String,
                                                dynamic
                                              >.from(
                                                controller
                                                    .firstCrewMainEvaluationData[mainKey][subKey],
                                              );

                                              oldSubMap['PF'] = value;
                                              log(oldSubMap.toString());

                                              final updatedMainMap = Map<
                                                String,
                                                dynamic
                                              >.from(
                                                controller
                                                    .firstCrewMainEvaluationData[mainKey],
                                              );

                                              updatedMainMap[subKey] =
                                                  oldSubMap;

                                              controller
                                                      .firstCrewMainEvaluationData[mainKey] =
                                                  updatedMainMap;

                                              controller
                                                  .firstCrewMainEvaluationData
                                                  .refresh();
                                            },
                                            decoration:
                                                CustomInputDecoration.customInputDecoration(
                                                  labelText: "PF",
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeConstant.SIZED_BOX_WIDTH,
                                        ),
                                        Expanded(
                                          child: DropdownButtonFormField<
                                            String
                                          >(
                                            validator: (value) {
                                              if (value == null) {
                                                return "Please select a value";
                                              }
                                              return null;
                                            },
                                            dropdownColor:
                                                ColorConstants.backgroundColor,
                                            value: null,
                                            items:
                                                ["1", "2", "3", "4", "5"]
                                                    .map(
                                                      (e) => DropdownMenuItem(
                                                        value: e,
                                                        child: Text(
                                                          e,
                                                          style: GoogleFonts.notoSans(
                                                            color:
                                                                ColorConstants
                                                                    .textPrimary,
                                                            fontSize:
                                                                SizeConstant
                                                                    .TEXT_SIZE_HINT,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                            onChanged: (value) {
                                              final oldSubMap = Map<
                                                String,
                                                dynamic
                                              >.from(
                                                controller
                                                    .firstCrewMainEvaluationData[mainKey][subKey],
                                              );

                                              oldSubMap['PM'] = value;
                                              log(oldSubMap.toString());

                                              final updatedMainMap = Map<
                                                String,
                                                dynamic
                                              >.from(
                                                controller
                                                    .firstCrewMainEvaluationData[mainKey],
                                              );

                                              updatedMainMap[subKey] =
                                                  oldSubMap;

                                              controller
                                                      .firstCrewMainEvaluationData[mainKey] =
                                                  updatedMainMap;

                                              controller
                                                  .firstCrewMainEvaluationData
                                                  .refresh();
                                            },
                                            decoration:
                                                CustomInputDecoration.customInputDecoration(
                                                  labelText: "PM",
                                                ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            )
                          else
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        checkColor: ColorConstants.whiteColor,
                                        value:
                                            controller
                                                .firstCrewMainEvaluationData[mainKey][subKey]['not_assigned'],
                                        onChanged: (val) {
                                          log('Else:  ${mainKey.toString()}');
                                          final oldSubMap = Map<
                                            String,
                                            dynamic
                                          >.from(
                                            controller
                                                .firstCrewMainEvaluationData[mainKey][subKey],
                                          );

                                          oldSubMap['not_assigned'] = val!;
                                          oldSubMap['assessment'] = "";
                                          oldSubMap['markers'] = "";

                                          final updatedMainMap = Map<
                                            String,
                                            dynamic
                                          >.from(
                                            controller
                                                .firstCrewMainEvaluationData[mainKey],
                                          );

                                          updatedMainMap[subKey] = oldSubMap;

                                          controller
                                                  .firstCrewMainEvaluationData[mainKey] =
                                              updatedMainMap;

                                          controller.firstCrewMainEvaluationData
                                              .refresh();
                                        },
                                      ),
                                      Text(
                                        "N/A",
                                        style: GoogleFonts.notoSans(
                                          color: ColorConstants.textPrimary,
                                          fontSize: SizeConstant.TEXT_SIZE,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConstant.SIZED_BOX_WIDTH,
                                      ),
                                      if (!controller
                                          .firstCrewMainEvaluationData[mainKey][subKey]['not_assigned']) ...[
                                        if (controller
                                                .firstCrewMainEvaluationData[mainKey][subKey]
                                                .toString()
                                                .contains('assessment') ||
                                            controller
                                                .firstCrewMainEvaluationData[mainKey][subKey]
                                                .toString()
                                                .contains('markers')) ...[
                                          Expanded(
                                            child: DropdownButtonFormField<
                                              String
                                            >(
                                              validator: (value) {
                                                if (value == null) {
                                                  return "Please select a value";
                                                }
                                                return null;
                                              },
                                              dropdownColor:
                                                  ColorConstants
                                                      .backgroundColor,
                                              value: null,
                                              items:
                                                  [
                                                        "Satisfactory",
                                                        "Unsatisfactory",
                                                      ]
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e,
                                                            style: GoogleFonts.notoSans(
                                                              color:
                                                                  ColorConstants
                                                                      .textPrimary,
                                                              fontSize:
                                                                  SizeConstant
                                                                      .TEXT_SIZE_HINT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                              onChanged: (value) {
                                                final oldSubMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .firstCrewMainEvaluationData[mainKey][subKey],
                                                );

                                                oldSubMap['assessment'] = value;
                                                log(oldSubMap.toString());

                                                final updatedMainMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .firstCrewMainEvaluationData[mainKey],
                                                );

                                                updatedMainMap[subKey] =
                                                    oldSubMap;

                                                controller
                                                        .firstCrewMainEvaluationData[mainKey] =
                                                    updatedMainMap;

                                                controller
                                                    .firstCrewMainEvaluationData
                                                    .refresh();
                                              },
                                              decoration:
                                                  CustomInputDecoration.customInputDecoration(
                                                    labelText: "Assessment",
                                                  ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: SizeConstant.SIZED_BOX_WIDTH,
                                          ),
                                          Expanded(
                                            child: DropdownButtonFormField<
                                              String
                                            >(
                                              validator: (value) {
                                                if (value == null) {
                                                  return "Please select a value";
                                                }
                                                return null;
                                              },
                                              dropdownColor:
                                                  ColorConstants
                                                      .backgroundColor,
                                              value: null,
                                              items:
                                                  ["1", "2", "3", "4", "5"]
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e,
                                                            style: GoogleFonts.notoSans(
                                                              color:
                                                                  ColorConstants
                                                                      .textPrimary,
                                                              fontSize:
                                                                  SizeConstant
                                                                      .TEXT_SIZE_HINT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                              onChanged: (value) {
                                                final oldSubMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .firstCrewMainEvaluationData[mainKey][subKey],
                                                );

                                                oldSubMap['markers'] = value;
                                                log(oldSubMap.toString());

                                                final updatedMainMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .firstCrewMainEvaluationData[mainKey],
                                                );

                                                updatedMainMap[subKey] =
                                                    oldSubMap;

                                                controller
                                                        .firstCrewMainEvaluationData[mainKey] =
                                                    updatedMainMap;

                                                controller
                                                    .firstCrewMainEvaluationData
                                                    .refresh();
                                              },
                                              decoration:
                                                  CustomInputDecoration.customInputDecoration(
                                                    labelText: "Markers",
                                                  ),
                                            ),
                                          ),
                                        ] else ...[
                                          Expanded(
                                            child: DropdownButtonFormField<
                                              String
                                            >(
                                              validator: (value) {
                                                if (value == null) {
                                                  return "Please select a value";
                                                }
                                                return null;
                                              },
                                              dropdownColor:
                                                  ColorConstants
                                                      .backgroundColor,
                                              value: null,
                                              items:
                                                  ["1", "2", "3", "4", "5"]
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e,
                                                            style: GoogleFonts.notoSans(
                                                              color:
                                                                  ColorConstants
                                                                      .textPrimary,
                                                              fontSize:
                                                                  SizeConstant
                                                                      .TEXT_SIZE_HINT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                              onChanged: (value) {
                                                final oldSubMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .firstCrewMainEvaluationData[mainKey][subKey],
                                                );

                                                oldSubMap['PF'] = value;
                                                log(oldSubMap.toString());

                                                final updatedMainMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .firstCrewMainEvaluationData[mainKey],
                                                );

                                                updatedMainMap[subKey] =
                                                    oldSubMap;

                                                controller
                                                        .firstCrewMainEvaluationData[mainKey] =
                                                    updatedMainMap;

                                                controller
                                                    .firstCrewMainEvaluationData
                                                    .refresh();
                                              },
                                              decoration:
                                                  CustomInputDecoration.customInputDecoration(
                                                    labelText: "PF",
                                                  ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: SizeConstant.SIZED_BOX_WIDTH,
                                          ),
                                          Expanded(
                                            child: DropdownButtonFormField<
                                              String
                                            >(
                                              validator: (value) {
                                                if (value == null) {
                                                  return "Please select a value";
                                                }
                                                return null;
                                              },
                                              dropdownColor:
                                                  ColorConstants
                                                      .backgroundColor,
                                              value: null,
                                              items:
                                                  ["1", "2", "3", "4", "5"]
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e,
                                                            style: GoogleFonts.notoSans(
                                                              color:
                                                                  ColorConstants
                                                                      .textPrimary,
                                                              fontSize:
                                                                  SizeConstant
                                                                      .TEXT_SIZE_HINT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                              onChanged: (value) {
                                                final oldSubMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .firstCrewMainEvaluationData[mainKey][subKey],
                                                );

                                                oldSubMap['PM'] = value;
                                                log(oldSubMap.toString());

                                                final updatedMainMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .firstCrewMainEvaluationData[mainKey],
                                                );

                                                updatedMainMap[subKey] =
                                                    oldSubMap;

                                                controller
                                                        .firstCrewMainEvaluationData[mainKey] =
                                                    updatedMainMap;

                                                controller
                                                    .firstCrewMainEvaluationData
                                                    .refresh();
                                              },
                                              decoration:
                                                  CustomInputDecoration.customInputDecoration(
                                                    labelText: "PM",
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "Crew 2",
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: SizeConstant.TEXT_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          if (mainKey.toString() ==
                                  'Aircraft Systems/Procedure' ||
                              mainKey.toString() ==
                                  'Abnormal/Emergency Procedure')
                            Expanded(
                              child: Column(
                                children: [
                                  if (!controller
                                      .secondCrewMainEvaluationData[mainKey][subKey]['not_assigned'])
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: SizeConstant.PADDING,
                                      ),
                                      child: TextFormField(
                                        focusNode: FocusNode(),
                                        decoration:
                                            CustomInputDecoration.customInputDecoration(
                                              labelText: 'Subject',
                                            ),
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a subject';
                                          }
                                          return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          log('Subject Second Crew:  $value');
                                          final oldSubMap = Map<
                                            String,
                                            dynamic
                                          >.from(
                                            controller
                                                .secondCrewMainEvaluationData[mainKey][subKey],
                                          );

                                          oldSubMap['subject'] = value;

                                          final updatedMainMap = Map<
                                            String,
                                            dynamic
                                          >.from(
                                            controller
                                                .secondCrewMainEvaluationData[mainKey],
                                          );

                                          updatedMainMap[subKey] = oldSubMap;

                                          controller
                                                  .secondCrewMainEvaluationData[mainKey] =
                                              updatedMainMap;

                                          controller
                                              .secondCrewMainEvaluationData
                                              .refresh();
                                        },
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        checkColor: ColorConstants.whiteColor,
                                        value:
                                            controller
                                                .secondCrewMainEvaluationData[mainKey][subKey]['not_assigned'],
                                        onChanged: (val) {
                                          log('Else:  ${mainKey.toString()}');
                                          final oldSubMap = Map<
                                            String,
                                            dynamic
                                          >.from(
                                            controller
                                                .secondCrewMainEvaluationData[mainKey][subKey],
                                          );

                                          oldSubMap['not_assigned'] = val!;
                                          oldSubMap['PF'] = "";
                                          oldSubMap['PM'] = "";
                                          oldSubMap['subject'] = "";

                                          final updatedMainMap = Map<
                                            String,
                                            dynamic
                                          >.from(
                                            controller
                                                .secondCrewMainEvaluationData[mainKey],
                                          );

                                          updatedMainMap[subKey] = oldSubMap;

                                          controller
                                                  .secondCrewMainEvaluationData[mainKey] =
                                              updatedMainMap;

                                          controller
                                              .secondCrewMainEvaluationData
                                              .refresh();
                                        },
                                      ),
                                      Text(
                                        "N/A",
                                        style: GoogleFonts.notoSans(
                                          color: ColorConstants.textPrimary,
                                          fontSize: SizeConstant.TEXT_SIZE,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConstant.SIZED_BOX_WIDTH,
                                      ),
                                      if (!controller
                                          .secondCrewMainEvaluationData[mainKey][subKey]['not_assigned']) ...[
                                        Expanded(
                                          child: DropdownButtonFormField<
                                            String
                                          >(
                                            validator: (value) {
                                              if (value == null) {
                                                return "Please select a value";
                                              }
                                              return null;
                                            },
                                            dropdownColor:
                                                ColorConstants.backgroundColor,
                                            value: null,
                                            items:
                                                ["1", "2", "3", "4", "5"]
                                                    .map(
                                                      (e) => DropdownMenuItem(
                                                        value: e,
                                                        child: Text(
                                                          e,
                                                          style: GoogleFonts.notoSans(
                                                            color:
                                                                ColorConstants
                                                                    .textPrimary,
                                                            fontSize:
                                                                SizeConstant
                                                                    .TEXT_SIZE_HINT,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                            onChanged: (value) {
                                              log(
                                                'Subject Second Crew:  $value',
                                              );
                                              final oldSubMap = Map<
                                                String,
                                                dynamic
                                              >.from(
                                                controller
                                                    .secondCrewMainEvaluationData[mainKey][subKey],
                                              );

                                              oldSubMap['PF'] = value;

                                              final updatedMainMap = Map<
                                                String,
                                                dynamic
                                              >.from(
                                                controller
                                                    .secondCrewMainEvaluationData[mainKey],
                                              );

                                              updatedMainMap[subKey] =
                                                  oldSubMap;

                                              controller
                                                      .secondCrewMainEvaluationData[mainKey] =
                                                  updatedMainMap;

                                              controller
                                                  .secondCrewMainEvaluationData
                                                  .refresh();
                                            },
                                            decoration:
                                                CustomInputDecoration.customInputDecoration(
                                                  labelText: "PF",
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeConstant.SIZED_BOX_WIDTH,
                                        ),
                                        Expanded(
                                          child: DropdownButtonFormField<
                                            String
                                          >(
                                            validator: (value) {
                                              if (value == null) {
                                                return "Please select a value";
                                              }
                                              return null;
                                            },
                                            dropdownColor:
                                                ColorConstants.backgroundColor,
                                            value: null,
                                            items:
                                                ["1", "2", "3", "4", "5"]
                                                    .map(
                                                      (e) => DropdownMenuItem(
                                                        value: e,
                                                        child: Text(
                                                          e,
                                                          style: GoogleFonts.notoSans(
                                                            color:
                                                                ColorConstants
                                                                    .textPrimary,
                                                            fontSize:
                                                                SizeConstant
                                                                    .TEXT_SIZE_HINT,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                            onChanged: (value) {
                                              log(
                                                'Subject Second Crew:  $value',
                                              );
                                              final oldSubMap = Map<
                                                String,
                                                dynamic
                                              >.from(
                                                controller
                                                    .secondCrewMainEvaluationData[mainKey][subKey],
                                              );

                                              oldSubMap['PM'] = value;

                                              final updatedMainMap = Map<
                                                String,
                                                dynamic
                                              >.from(
                                                controller
                                                    .secondCrewMainEvaluationData[mainKey],
                                              );

                                              updatedMainMap[subKey] =
                                                  oldSubMap;

                                              controller
                                                      .secondCrewMainEvaluationData[mainKey] =
                                                  updatedMainMap;

                                              controller
                                                  .secondCrewMainEvaluationData
                                                  .refresh();
                                            },
                                            decoration:
                                                CustomInputDecoration.customInputDecoration(
                                                  labelText: "PM",
                                                ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            )
                          else
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        checkColor: ColorConstants.whiteColor,
                                        value:
                                            controller
                                                .secondCrewMainEvaluationData[mainKey][subKey]['not_assigned'],
                                        onChanged: (val) {
                                          log('Else:  ${mainKey.toString()}');
                                          final oldSubMap = Map<
                                            String,
                                            dynamic
                                          >.from(
                                            controller
                                                .secondCrewMainEvaluationData[mainKey][subKey],
                                          );

                                          oldSubMap['not_assigned'] = val!;
                                          oldSubMap['assessment'] = "";
                                          oldSubMap['markers'] = "";

                                          final updatedMainMap = Map<
                                            String,
                                            dynamic
                                          >.from(
                                            controller
                                                .secondCrewMainEvaluationData[mainKey],
                                          );

                                          updatedMainMap[subKey] = oldSubMap;

                                          controller
                                                  .secondCrewMainEvaluationData[mainKey] =
                                              updatedMainMap;

                                          controller
                                              .secondCrewMainEvaluationData
                                              .refresh();
                                        },
                                      ),
                                      Text(
                                        "N/A",
                                        style: GoogleFonts.notoSans(
                                          color: ColorConstants.textPrimary,
                                          fontSize: SizeConstant.TEXT_SIZE,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConstant.SIZED_BOX_WIDTH,
                                      ),
                                      if (!controller
                                          .secondCrewMainEvaluationData[mainKey][subKey]['not_assigned']) ...[
                                        if (controller
                                                .secondCrewMainEvaluationData[mainKey][subKey]
                                                .toString()
                                                .contains('assessment') ||
                                            controller
                                                .secondCrewMainEvaluationData[mainKey][subKey]
                                                .toString()
                                                .contains('markers')) ...[
                                          Expanded(
                                            child: DropdownButtonFormField<
                                              String
                                            >(
                                              validator: (value) {
                                                if (value == null) {
                                                  return "Please select a value";
                                                }
                                                return null;
                                              },
                                              dropdownColor:
                                                  ColorConstants
                                                      .backgroundColor,
                                              value: null,
                                              items:
                                                  [
                                                        "Satisfactory",
                                                        "Unsatisfactory",
                                                      ]
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e,
                                                            style: GoogleFonts.notoSans(
                                                              color:
                                                                  ColorConstants
                                                                      .textPrimary,
                                                              fontSize:
                                                                  SizeConstant
                                                                      .TEXT_SIZE_HINT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                              onChanged: (value) {
                                                log(
                                                  'Subject Second Crew:  $value',
                                                );
                                                final oldSubMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .secondCrewMainEvaluationData[mainKey][subKey],
                                                );

                                                oldSubMap['assessment'] = value;

                                                final updatedMainMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .secondCrewMainEvaluationData[mainKey],
                                                );

                                                updatedMainMap[subKey] =
                                                    oldSubMap;

                                                controller
                                                        .secondCrewMainEvaluationData[mainKey] =
                                                    updatedMainMap;

                                                controller
                                                    .secondCrewMainEvaluationData
                                                    .refresh();
                                              },
                                              decoration:
                                                  CustomInputDecoration.customInputDecoration(
                                                    labelText: "Assessment",
                                                  ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: SizeConstant.SIZED_BOX_WIDTH,
                                          ),
                                          Expanded(
                                            child: DropdownButtonFormField<
                                              String
                                            >(
                                              validator: (value) {
                                                if (value == null) {
                                                  return "Please select a value";
                                                }
                                                return null;
                                              },
                                              dropdownColor:
                                                  ColorConstants
                                                      .backgroundColor,
                                              value: null,
                                              items:
                                                  ["1", "2", "3", "4", "5"]
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e,
                                                            style: GoogleFonts.notoSans(
                                                              color:
                                                                  ColorConstants
                                                                      .textPrimary,
                                                              fontSize:
                                                                  SizeConstant
                                                                      .TEXT_SIZE_HINT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                              onChanged: (value) {
                                                log(
                                                  'Subject Second Crew:  $value',
                                                );
                                                final oldSubMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .secondCrewMainEvaluationData[mainKey][subKey],
                                                );

                                                oldSubMap['markers'] = value;

                                                final updatedMainMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .secondCrewMainEvaluationData[mainKey],
                                                );

                                                updatedMainMap[subKey] =
                                                    oldSubMap;

                                                controller
                                                        .secondCrewMainEvaluationData[mainKey] =
                                                    updatedMainMap;

                                                controller
                                                    .secondCrewMainEvaluationData
                                                    .refresh();
                                              },
                                              decoration:
                                                  CustomInputDecoration.customInputDecoration(
                                                    labelText: "Markers",
                                                  ),
                                            ),
                                          ),
                                        ] else ...[
                                          Expanded(
                                            child: DropdownButtonFormField<
                                              String
                                            >(
                                              validator: (value) {
                                                if (value == null) {
                                                  return "Please select a value";
                                                }
                                                return null;
                                              },
                                              dropdownColor:
                                                  ColorConstants
                                                      .backgroundColor,
                                              value: null,
                                              items:
                                                  ["1", "2", "3", "4", "5"]
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e,
                                                            style: GoogleFonts.notoSans(
                                                              color:
                                                                  ColorConstants
                                                                      .textPrimary,
                                                              fontSize:
                                                                  SizeConstant
                                                                      .TEXT_SIZE_HINT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                              onChanged: (value) {
                                                log(
                                                  'Subject Second Crew:  $value',
                                                );
                                                final oldSubMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .secondCrewMainEvaluationData[mainKey][subKey],
                                                );

                                                oldSubMap['PF'] = value;

                                                final updatedMainMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .secondCrewMainEvaluationData[mainKey],
                                                );

                                                updatedMainMap[subKey] =
                                                    oldSubMap;

                                                controller
                                                        .secondCrewMainEvaluationData[mainKey] =
                                                    updatedMainMap;

                                                controller
                                                    .secondCrewMainEvaluationData
                                                    .refresh();
                                              },
                                              decoration:
                                                  CustomInputDecoration.customInputDecoration(
                                                    labelText: "PF",
                                                  ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: SizeConstant.SIZED_BOX_WIDTH,
                                          ),
                                          Expanded(
                                            child: DropdownButtonFormField<
                                              String
                                            >(
                                              validator: (value) {
                                                if (value == null) {
                                                  return "Please select a value";
                                                }
                                                return null;
                                              },
                                              dropdownColor:
                                                  ColorConstants
                                                      .backgroundColor,
                                              value: null,
                                              items:
                                                  ["1", "2", "3", "4", "5"]
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e,
                                                            style: GoogleFonts.notoSans(
                                                              color:
                                                                  ColorConstants
                                                                      .textPrimary,
                                                              fontSize:
                                                                  SizeConstant
                                                                      .TEXT_SIZE_HINT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                              onChanged: (value) {
                                                log(
                                                  'Subject Second Crew:  $value',
                                                );
                                                final oldSubMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .secondCrewMainEvaluationData[mainKey][subKey],
                                                );

                                                oldSubMap['PM'] = value;

                                                final updatedMainMap = Map<
                                                  String,
                                                  dynamic
                                                >.from(
                                                  controller
                                                      .secondCrewMainEvaluationData[mainKey],
                                                );

                                                updatedMainMap[subKey] =
                                                    oldSubMap;

                                                controller
                                                        .secondCrewMainEvaluationData[mainKey] =
                                                    updatedMainMap;

                                                controller
                                                    .secondCrewMainEvaluationData
                                                    .refresh();
                                              },
                                              decoration:
                                                  CustomInputDecoration.customInputDecoration(
                                                    labelText: "PM",
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      Divider(color: ColorConstants.dividerColor, thickness: 1),
                    ],
                  ),
                ),
              );
            }).toList();
      }

      widgets.add(
        Padding(
          padding: EdgeInsets.all(SizeConstant.VERTICAL_PADDING),
          child: ExpansionTile(
            title: Text(
              mainKey,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: SizeConstant.TEXT_SIZE,
              ),
            ),
            backgroundColor: ColorConstants.backgroundColor,
            collapsedBackgroundColor: ColorConstants.backgroundColor,
            textColor: ColorConstants.textPrimary,
            collapsedTextColor: ColorConstants.textPrimary,
            iconColor: ColorConstants.blackColor,
            collapsedIconColor: ColorConstants.blackColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: ColorConstants.activeColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            collapsedShape: RoundedRectangleBorder(
              side: BorderSide(color: ColorConstants.blackColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            maintainState: true,
            children: childrenWidgets,
          ),
        ),
      );
    });

    return widgets;
  }

  List<Widget> _buildHumanFactorAssessment() {
    List<Widget> widgets = [];

    controller.humanEvaluationData.forEach((mainKey, subMap) {
      List<Widget> childrenWidgets = [];

      if (subMap is Map && subMap.keys.every((k) => k is String)) {
        childrenWidgets =
            subMap.keys.map<Widget>((subKey) {
              return Obx(
                () => Padding(
                  padding: EdgeInsets.all(SizeConstant.PADDING),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subKey,
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConstant.TEXT_SIZE,
                        ),
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      Text(
                        "Crew 1",
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: SizeConstant.TEXT_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (!controller
                          .firstCrewHumanEvaluationData[mainKey][subKey]['not_assigned'])
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConstant.PADDING,
                          ),
                          child: TextFormField(
                            focusNode: FocusNode(),
                            decoration:
                                CustomInputDecoration.customInputDecoration(
                                  labelText: 'Subject',
                                ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a subject';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              final oldSubMap = Map<String, dynamic>.from(
                                controller
                                    .firstCrewHumanEvaluationData[mainKey][subKey],
                              );

                              oldSubMap['subject'] = value;
                              log(oldSubMap.toString());

                              final updatedMainMap = Map<String, dynamic>.from(
                                controller
                                    .firstCrewHumanEvaluationData[mainKey],
                              );

                              updatedMainMap[subKey] = oldSubMap;

                              controller.firstCrewHumanEvaluationData[mainKey] =
                                  updatedMainMap;

                              controller.firstCrewHumanEvaluationData.refresh();
                            },
                          ),
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor: ColorConstants.whiteColor,
                                      value:
                                          controller
                                              .firstCrewHumanEvaluationData[mainKey][subKey]['not_assigned'],
                                      onChanged: (val) {
                                        final oldSubMap = Map<
                                          String,
                                          dynamic
                                        >.from(
                                          controller
                                              .firstCrewHumanEvaluationData[mainKey][subKey],
                                        );

                                        oldSubMap['not_assigned'] = val!;
                                        oldSubMap['PF'] = "";
                                        oldSubMap['PM'] = "";

                                        final updatedMainMap = Map<
                                          String,
                                          dynamic
                                        >.from(
                                          controller
                                              .firstCrewHumanEvaluationData[mainKey],
                                        );

                                        updatedMainMap[subKey] = oldSubMap;

                                        controller
                                                .firstCrewHumanEvaluationData[mainKey] =
                                            updatedMainMap;

                                        controller.firstCrewHumanEvaluationData
                                            .refresh();
                                      },
                                    ),
                                    Text(
                                      "N/A",
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.textPrimary,
                                        fontSize: SizeConstant.TEXT_SIZE,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConstant.SIZED_BOX_WIDTH,
                                    ),
                                    if (!controller
                                        .firstCrewHumanEvaluationData[mainKey][subKey]['not_assigned']) ...[
                                      Expanded(
                                        child: DropdownButtonFormField<String>(
                                          validator: (value) {
                                            if (value == null) {
                                              return "Please select a value";
                                            }
                                            return null;
                                          },
                                          dropdownColor:
                                              ColorConstants.backgroundColor,
                                          value: null,
                                          items:
                                              ["1", "2", "3", "4", "5"]
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(
                                                        e,
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
                                                    ),
                                                  )
                                                  .toList(),
                                          onChanged: (value) {
                                            final oldSubMap = Map<
                                              String,
                                              dynamic
                                            >.from(
                                              controller
                                                  .firstCrewHumanEvaluationData[mainKey][subKey],
                                            );

                                            oldSubMap['PF'] = value;
                                            log(oldSubMap.toString());

                                            final updatedMainMap = Map<
                                              String,
                                              dynamic
                                            >.from(
                                              controller
                                                  .firstCrewHumanEvaluationData[mainKey],
                                            );

                                            updatedMainMap[subKey] = oldSubMap;

                                            controller
                                                    .firstCrewHumanEvaluationData[mainKey] =
                                                updatedMainMap;

                                            controller
                                                .firstCrewHumanEvaluationData
                                                .refresh();
                                          },
                                          decoration:
                                              CustomInputDecoration.customInputDecoration(
                                                labelText: "PF",
                                              ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConstant.SIZED_BOX_WIDTH,
                                      ),
                                      Expanded(
                                        child: DropdownButtonFormField<String>(
                                          validator: (value) {
                                            if (value == null) {
                                              return "Please select a value";
                                            }
                                            return null;
                                          },
                                          dropdownColor:
                                              ColorConstants.backgroundColor,
                                          value: null,
                                          items:
                                              ["1", "2", "3", "4", "5"]
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(
                                                        e,
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
                                                    ),
                                                  )
                                                  .toList(),
                                          onChanged: (value) {
                                            final oldSubMap = Map<
                                              String,
                                              dynamic
                                            >.from(
                                              controller
                                                  .firstCrewHumanEvaluationData[mainKey][subKey],
                                            );

                                            oldSubMap['PM'] = value;
                                            log(oldSubMap.toString());

                                            final updatedMainMap = Map<
                                              String,
                                              dynamic
                                            >.from(
                                              controller
                                                  .firstCrewHumanEvaluationData[mainKey],
                                            );

                                            updatedMainMap[subKey] = oldSubMap;

                                            controller
                                                    .firstCrewHumanEvaluationData[mainKey] =
                                                updatedMainMap;

                                            controller
                                                .firstCrewHumanEvaluationData
                                                .refresh();
                                          },
                                          decoration:
                                              CustomInputDecoration.customInputDecoration(
                                                labelText: "PM",
                                              ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Crew 2",
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: SizeConstant.TEXT_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (!controller
                          .secondCrewHumanEvaluationData[mainKey][subKey]['not_assigned'])
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConstant.PADDING,
                          ),
                          child: TextFormField(
                            focusNode: FocusNode(),
                            decoration:
                                CustomInputDecoration.customInputDecoration(
                                  labelText: 'Subject',
                                ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a subject';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              final oldSubMap = Map<String, dynamic>.from(
                                controller
                                    .secondCrewHumanEvaluationData[mainKey][subKey],
                              );

                              oldSubMap['subject'] = value;
                              log(oldSubMap.toString());

                              final updatedMainMap = Map<String, dynamic>.from(
                                controller
                                    .secondCrewHumanEvaluationData[mainKey],
                              );

                              updatedMainMap[subKey] = oldSubMap;

                              controller
                                      .secondCrewHumanEvaluationData[mainKey] =
                                  updatedMainMap;

                              controller.secondCrewHumanEvaluationData
                                  .refresh();
                            },
                          ),
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor: ColorConstants.whiteColor,
                                      value:
                                          controller
                                              .secondCrewHumanEvaluationData[mainKey][subKey]['not_assigned'],
                                      onChanged: (val) {
                                        final oldSubMap = Map<
                                          String,
                                          dynamic
                                        >.from(
                                          controller
                                              .secondCrewHumanEvaluationData[mainKey][subKey],
                                        );

                                        oldSubMap['not_assigned'] = val!;
                                        oldSubMap['PF'] = "";
                                        oldSubMap['PM'] = "";

                                        final updatedMainMap = Map<
                                          String,
                                          dynamic
                                        >.from(
                                          controller
                                              .secondCrewHumanEvaluationData[mainKey],
                                        );

                                        updatedMainMap[subKey] = oldSubMap;

                                        controller
                                                .secondCrewHumanEvaluationData[mainKey] =
                                            updatedMainMap;

                                        controller.secondCrewHumanEvaluationData
                                            .refresh();
                                      },
                                    ),
                                    Text(
                                      "N/A",
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.textPrimary,
                                        fontSize: SizeConstant.TEXT_SIZE,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConstant.SIZED_BOX_WIDTH,
                                    ),
                                    if (!controller
                                        .secondCrewHumanEvaluationData[mainKey][subKey]['not_assigned']) ...[
                                      Expanded(
                                        child: DropdownButtonFormField<String>(
                                          validator: (value) {
                                            if (value == null) {
                                              return "Please select a value";
                                            }
                                            return null;
                                          },
                                          dropdownColor:
                                              ColorConstants.backgroundColor,
                                          value: null,
                                          items:
                                              ["1", "2", "3", "4", "5"]
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(
                                                        e,
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
                                                    ),
                                                  )
                                                  .toList(),
                                          onChanged: (value) {
                                            log('Subject Second Crew:  $value');
                                            final oldSubMap = Map<
                                              String,
                                              dynamic
                                            >.from(
                                              controller
                                                  .secondCrewHumanEvaluationData[mainKey][subKey],
                                            );

                                            oldSubMap['PF'] = value;

                                            final updatedMainMap = Map<
                                              String,
                                              dynamic
                                            >.from(
                                              controller
                                                  .secondCrewHumanEvaluationData[mainKey],
                                            );

                                            updatedMainMap[subKey] = oldSubMap;

                                            controller
                                                    .secondCrewHumanEvaluationData[mainKey] =
                                                updatedMainMap;

                                            controller
                                                .secondCrewHumanEvaluationData
                                                .refresh();
                                          },
                                          decoration:
                                              CustomInputDecoration.customInputDecoration(
                                                labelText: "PF",
                                              ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConstant.SIZED_BOX_WIDTH,
                                      ),
                                      Expanded(
                                        child: DropdownButtonFormField<String>(
                                          validator: (value) {
                                            if (value == null) {
                                              return "Please select a value";
                                            }
                                            return null;
                                          },
                                          dropdownColor:
                                              ColorConstants.backgroundColor,
                                          value: null,
                                          items:
                                              ["1", "2", "3", "4", "5"]
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(
                                                        e,
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
                                                    ),
                                                  )
                                                  .toList(),
                                          onChanged: (value) {
                                            log('Subject Second Crew:  $value');
                                            final oldSubMap = Map<
                                              String,
                                              dynamic
                                            >.from(
                                              controller
                                                  .secondCrewHumanEvaluationData[mainKey][subKey],
                                            );

                                            oldSubMap['PM'] = value;

                                            final updatedMainMap = Map<
                                              String,
                                              dynamic
                                            >.from(
                                              controller
                                                  .secondCrewHumanEvaluationData[mainKey],
                                            );

                                            updatedMainMap[subKey] = oldSubMap;

                                            controller
                                                    .secondCrewHumanEvaluationData[mainKey] =
                                                updatedMainMap;

                                            controller
                                                .secondCrewHumanEvaluationData
                                                .refresh();
                                          },
                                          decoration:
                                              CustomInputDecoration.customInputDecoration(
                                                labelText: "PM",
                                              ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      Divider(color: ColorConstants.dividerColor, thickness: 1),
                    ],
                  ),
                ),
              );
            }).toList();
      }

      widgets.add(
        Padding(
          padding: EdgeInsets.all(SizeConstant.VERTICAL_PADDING),
          child: ExpansionTile(
            title: Text(
              mainKey,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: SizeConstant.TEXT_SIZE,
              ),
            ),
            backgroundColor: ColorConstants.backgroundColor,
            collapsedBackgroundColor: ColorConstants.backgroundColor,
            textColor: ColorConstants.textPrimary,
            collapsedTextColor: ColorConstants.textPrimary,
            iconColor: ColorConstants.blackColor,
            collapsedIconColor: ColorConstants.blackColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: ColorConstants.activeColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            collapsedShape: RoundedRectangleBorder(
              side: BorderSide(color: ColorConstants.blackColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            maintainState: true,
            children: childrenWidgets,
          ),
        ),
      );
    });

    return widgets;
  }
}
