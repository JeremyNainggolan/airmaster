// ignore_for_file: camel_case_types, deprecated_member_use

import 'dart:developer';

import 'package:airmaster/screens/home/ts_1/home/view/assessment/evaluation/controller/evaluation_assessment_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:airmaster/helpers/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Evaluation_View extends GetView<Evaluation_Controller> {
  const Evaluation_View({super.key});

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
            "Assessment | Evaluation",
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
                      CustomDivider(divider: 'Main Assessment'),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConstant.HORIZONTAL_PADDING,
                        ),
                        child: Obx(
                          () => Column(children: _buildEvaluationAssessment()),
                        ),
                      ),

                      CustomDivider(divider: 'Human Factor Assessment'),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConstant.TOP_PADDING),
                    child: ElevatedButton(
                      onPressed: () async {
                        log(controller.firstCrewMainEvaluationData.toString());
                        log(controller.secondCrewMainEvaluationData.toString());
                        if (controller.formKey.currentState!.validate()) {
                          log('Form is valid');
                          // Get.dialog(
                          //   Center(
                          //     child: LoadingAnimationWidget.hexagonDots(
                          //       color: ColorConstants.primaryColor,
                          //       size: 50,
                          //     ),
                          //   ),
                          // );

                          // await controller.candidateAssessment();
                          // await Future.delayed(Duration(seconds: 1));

                          // Get.toNamed(AppRoutes.TS1_FLIGHT_DETAILS);
                        } else {
                          log('Form is invalid');
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

  List<Widget> _buildEvaluationAssessment() {
    List<Widget> widgets = [];

    controller.mainEvaluationData.forEach((mainKey, subMap) {
      List<Widget> childrenWidgets = [];

      if (subMap is Map && subMap.keys.every((k) => k is String)) {
        childrenWidgets =
            subMap.keys.map<Widget>((subKey) {
              return Padding(
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
                                controller
                                        .firstCrewMainEvaluationData[mainKey][subKey]['not_assigned']
                                    ? SizedBox(
                                      width: SizeConstant.SIZED_BOX_WIDTH,
                                    )
                                    : Padding(
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
                                        oldSubMap['assessment'] = "";
                                        oldSubMap['markers'] = "";
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
                                    controller
                                            .firstCrewMainEvaluationData[mainKey][subKey]['not_assigned']
                                        ? SizedBox(
                                          width: SizeConstant.SIZED_BOX_WIDTH,
                                        )
                                        : Expanded(
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
                                    controller
                                            .firstCrewMainEvaluationData[mainKey][subKey]['not_assigned']
                                        ? SizedBox(
                                          width: SizeConstant.SIZED_BOX_WIDTH,
                                        )
                                        : Expanded(
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
                                    controller
                                            .firstCrewMainEvaluationData[mainKey][subKey]['not_assigned']
                                        ? SizedBox(
                                          width: SizeConstant.SIZED_BOX_WIDTH,
                                        )
                                        : controller
                                            .firstCrewMainEvaluationData[mainKey][subKey]
                                            .toString()
                                            .contains('assessment')
                                        ? Expanded(
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
                                        )
                                        : Expanded(
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
                                    controller
                                            .firstCrewMainEvaluationData[mainKey][subKey]['not_assigned']
                                        ? SizedBox(
                                          width: SizeConstant.SIZED_BOX_WIDTH,
                                        )
                                        : controller
                                            .firstCrewMainEvaluationData[mainKey][subKey]
                                            .toString()
                                            .contains('markers')
                                        ? Expanded(
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
                                        )
                                        : Expanded(
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
                                controller
                                        .secondCrewMainEvaluationData[mainKey][subKey]['not_assigned']
                                    ? SizedBox(
                                      width: SizeConstant.SIZED_BOX_WIDTH,
                                    )
                                    : Padding(
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
                                        oldSubMap['assessment'] = "";
                                        oldSubMap['markers'] = "";
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

                                        controller.secondCrewMainEvaluationData
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
                                    controller
                                            .secondCrewMainEvaluationData[mainKey][subKey]['not_assigned']
                                        ? SizedBox(
                                          width: SizeConstant.SIZED_BOX_WIDTH,
                                        )
                                        : Expanded(
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
                                    controller
                                            .secondCrewMainEvaluationData[mainKey][subKey]['not_assigned']
                                        ? SizedBox(
                                          width: SizeConstant.SIZED_BOX_WIDTH,
                                        )
                                        : Expanded(
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

                                        controller.secondCrewMainEvaluationData
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
                                    controller
                                            .secondCrewMainEvaluationData[mainKey][subKey]['not_assigned']
                                        ? SizedBox(
                                          width: SizeConstant.SIZED_BOX_WIDTH,
                                        )
                                        : controller
                                            .secondCrewMainEvaluationData[mainKey][subKey]
                                            .toString()
                                            .contains('assessment')
                                        ? Expanded(
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
                                        )
                                        : Expanded(
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
                                    controller
                                            .secondCrewMainEvaluationData[mainKey][subKey]['not_assigned']
                                        ? SizedBox(
                                          width: SizeConstant.SIZED_BOX_WIDTH,
                                        )
                                        : controller
                                            .secondCrewMainEvaluationData[mainKey][subKey]
                                            .toString()
                                            .contains('markers')
                                        ? Expanded(
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
                                        )
                                        : Expanded(
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
              );
            }).toList();
      }

      widgets.add(
        Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
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
              Get.back(result: true);
            },
          ),
        ],
      ),
    );
  }
}
