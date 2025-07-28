import 'package:airmaster/screens/home/training_card/home/home_instructor/view/attendance_list/view/total_trainee/view/scoring_trainee/controller/scoring_trainee_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';

class Ins_ScoringTrainee extends GetView<Ins_ScoringTrainee_Controller> {
  const Ins_ScoringTrainee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () => Get.back(),
        ),
        title: const Text('Profile Trainee'),
        titleTextStyle: GoogleFonts.notoSans(
          color: ColorConstants.textSecondary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: Obx(
        () =>
            controller.isLoading.value
                ? Center(
                  child: LoadingAnimationWidget.hexagonDots(
                    color: ColorConstants.primaryColor,
                    size: 50,
                  ),
                )
                : controller.traineeDetails['status'] == 'done'
                ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 60.0,
                                  bottom: 20.0,
                                ),
                                child: Container(
                                  height: 150.0,
                                  width: 150.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        spreadRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child:
                                        controller.traineeDetails['photo_url'] !=
                                                null
                                            ? Image.network(
                                              controller
                                                  .traineeDetails['photo_url'],
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => Icon(Icons.broken_image),
                                              fit: BoxFit.cover,
                                            )
                                            : CircleAvatar(
                                              backgroundColor: Colors.blueGrey,
                                              child: Text(
                                                (controller.traineeDetails['trainee_name'] ??
                                                        '?')
                                                    .toString()
                                                    .substring(0, 1)
                                                    .toUpperCase(),
                                                style: GoogleFonts.notoSans(
                                                  fontSize: 72,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10.0),

                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                bottom: 20.0,
                                right: 20.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "NAME",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          ': ',
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: Text(
                                          "${controller.traineeDetails['trainee_name']}",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10.0),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "RANK",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          ': ',
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: Text(
                                          "${controller.traineeDetails['trainee_rank']}",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10.0),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "SCORE",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          ': ',
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width: 70,
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            canvasColor:
                                                ColorConstants.whiteColor,
                                          ),
                                          child: DropdownButtonFormField<
                                            String
                                          >(
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            value:
                                                controller
                                                        .scoreValue
                                                        .value
                                                        .isNotEmpty
                                                    ? controller
                                                        .scoreValue
                                                        .value
                                                    : null,
                                            items:
                                                ['PASS', 'FAIL'].map((
                                                  String value,
                                                ) {
                                                  return DropdownMenuItem<
                                                    String
                                                  >(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                            onChanged: (String? newValue) {
                                              controller.scoreValue.value =
                                                  newValue ??
                                                  controller.scoreValue.value;
                                            },
                                            decoration:
                                                controller.scoreValue.value ==
                                                        'PASS'
                                                    ? InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          ColorConstants
                                                              .passColor,
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 2,
                                                            horizontal: 5,
                                                          ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstants
                                                                  .passColor,
                                                        ),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstants
                                                                  .passColor,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstants
                                                                  .passColor,
                                                        ),
                                                      ),
                                                    )
                                                    : InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          ColorConstants
                                                              .failColor,
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 2,
                                                            horizontal: 5,
                                                          ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstants
                                                                  .failColor,
                                                        ),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstants
                                                                  .failColor,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstants
                                                                  .failColor,
                                                        ),
                                                      ),
                                                    ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10.0),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "GRADE",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          ': ',
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: TextField(
                                              controller:
                                                  controller.gradeController,
                                              keyboardType:
                                                  TextInputType.number,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                      bottom: 4,
                                                    ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            ColorConstants
                                                                .labelColor,
                                                      ),
                                                    ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            ColorConstants
                                                                .labelColor,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),

                                          controller.gradeError.value.isNotEmpty
                                              ? Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 4.0,
                                                ),
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    controller.gradeError.value,
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 30.0),

                                  Text(
                                    'Communication Skills',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  Text(
                                    'Clear and effective communication',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.normal,
                                      color: ColorConstants.hintColor,
                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Very Poor',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Excellent',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SliderTheme(
                                    data: SliderThemeData(
                                      trackHeight: 3.0,
                                      valueIndicatorTextStyle: TextStyle(
                                        color: ColorConstants.whiteColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    child: Slider(
                                      value:
                                          controller.communicationScore.value,
                                      min: 0,
                                      max: 5,
                                      divisions: 5,
                                      activeColor:
                                          ColorConstants.sliderActiveColor,
                                      inactiveColor:
                                          ColorConstants.sliderInactiveColor,
                                      label:
                                          controller.communicationScore.value
                                              .toString(),
                                      onChanged: (value) {
                                        controller.communicationScore.value =
                                            value;
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),

                                  Text(
                                    'Knowledge Acquisition',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  Text(
                                    'Understanding and applying training materials',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.normal,
                                      color: ColorConstants.hintColor,
                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Very Low',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Very High',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SliderTheme(
                                    data: SliderThemeData(
                                      trackHeight: 3.0,
                                      valueIndicatorTextStyle: TextStyle(
                                        color: ColorConstants.whiteColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    child: Slider(
                                      value: controller.knowledgeScore.value,
                                      min: 0,
                                      max: 5,
                                      divisions: 5,
                                      activeColor:
                                          ColorConstants
                                              .sliderActiveColorSecondary,
                                      inactiveColor:
                                          ColorConstants.sliderInactiveColor,
                                      label:
                                          controller.knowledgeScore.value
                                              .toString(),
                                      onChanged: (value) {
                                        controller.knowledgeScore.value = value;
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),

                                  Text(
                                    'Active Participation',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  Text(
                                    'Engaging actively',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.normal,
                                      color: ColorConstants.hintColor,
                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Very Low',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Very High',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SliderTheme(
                                    data: SliderThemeData(
                                      trackHeight: 3.0,
                                      valueIndicatorTextStyle: TextStyle(
                                        color: ColorConstants.whiteColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    child: Slider(
                                      value:
                                          controller
                                              .activeParticipationScore
                                              .value,
                                      min: 0,
                                      max: 5,
                                      divisions: 5,
                                      activeColor:
                                          ColorConstants
                                              .sliderActiveColorTertiary,
                                      inactiveColor:
                                          ColorConstants.sliderInactiveColor,
                                      label:
                                          controller
                                              .activeParticipationScore
                                              .value
                                              .toString(),
                                      onChanged: (value) {
                                        controller
                                            .activeParticipationScore
                                            .value = value;
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),

                                  Text(
                                    'Provided Additional Information',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  TextFormField(
                                    controller:
                                        controller.additionalInfoController,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Enter any additional information here',
                                      hintStyle: TextStyle(
                                        color: ColorConstants.hintColor,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: ColorConstants.labelColor,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  controller
                                          .additionalInfoError
                                          .value
                                          .isNotEmpty
                                      ? Padding(
                                        padding: const EdgeInsets.only(
                                          top: 4.0,
                                        ),
                                        child: Text(
                                          controller.additionalInfoError.value,
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                      : const SizedBox.shrink(),

                                  CheckboxListTile(
                                    title: Text(
                                      'I agree with all of the results above',
                                    ),
                                    value: controller.isAgreed.value,
                                    onChanged: (value) {
                                      controller.isAgreed.value =
                                          value ?? false;

                                      if (value == true) {
                                        controller.agreeError.value = '';
                                      }
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    activeColor: ColorConstants.successColor,
                                    checkColor: ColorConstants.whiteColor,
                                  ),

                                  controller.agreeError.value.isNotEmpty
                                      ? Text(
                                        controller.agreeError.value,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      )
                                      : const SizedBox.shrink(),

                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        bool isValid = true;

                                        if (!controller.isAgreed.value) {
                                          controller.agreeError.value =
                                              'Please confirm your agreement first.';
                                          isValid = false;
                                        } else {
                                          controller.agreeError.value = '';
                                        }

                                        if (controller.gradeController.text
                                            .trim()
                                            .isEmpty) {
                                          controller.gradeError.value =
                                              'Grade is required.';
                                          isValid = false;
                                        } else {
                                          controller.gradeError.value = '';
                                        }

                                        if (controller
                                            .additionalInfoController
                                            .text
                                            .trim()
                                            .isEmpty) {
                                          controller.additionalInfoError.value =
                                              'Additional info is required.';
                                          isValid = false;
                                        } else {
                                          controller.additionalInfoError.value =
                                              '';
                                        }

                                        if (!isValid) return;

                                        controller.submitScore();
                                      },

                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorConstants.successColor,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12.0,
                                          horizontal: 24.0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Submit Score',
                                        style: GoogleFonts.notoSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstants.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 60.0,
                                  bottom: 20.0,
                                ),
                                child: Container(
                                  height: 150.0,
                                  width: 150.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        spreadRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child:
                                        controller.traineeDetails['photo_url'] !=
                                                null
                                            ? Image.network(
                                              controller
                                                  .traineeDetails['photo_url'],
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => Icon(Icons.broken_image),
                                              fit: BoxFit.cover,
                                            )
                                            : CircleAvatar(
                                              backgroundColor: Colors.blueGrey,
                                              child: Text(
                                                (controller.traineeDetails['trainee_name'] ??
                                                        '?')
                                                    .toString()
                                                    .substring(0, 1)
                                                    .toUpperCase(),
                                                style: GoogleFonts.notoSans(
                                                  fontSize: 72,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10.0),

                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                bottom: 20.0,
                                right: 20.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "NAME",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          ': ',
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: Text(
                                          "${controller.traineeDetails['trainee_name']}",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10.0),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "RANK",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          ': ',
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: Text(
                                          "${controller.traineeDetails['trainee_rank']}",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10.0),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "SCORE",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          ': ',
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width: 70,
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            canvasColor:
                                                ColorConstants.whiteColor,
                                          ),
                                          child: DropdownButtonFormField<
                                            String
                                          >(
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            value:
                                                controller
                                                        .scoreValue
                                                        .value
                                                        .isNotEmpty
                                                    ? controller
                                                        .scoreValue
                                                        .value
                                                    : null,
                                            items:
                                                ['PASS', 'FAIL'].map((
                                                  String value,
                                                ) {
                                                  return DropdownMenuItem<
                                                    String
                                                  >(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                            onChanged: (String? newValue) {
                                              controller.scoreValue.value =
                                                  newValue ?? '';
                                            },
                                            decoration:
                                                controller.scoreValue.value ==
                                                        'PASS'
                                                    ? InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          ColorConstants
                                                              .passColor,
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 2,
                                                            horizontal: 5,
                                                          ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstants
                                                                  .passColor,
                                                        ),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstants
                                                                  .passColor,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstants
                                                                  .passColor,
                                                        ),
                                                      ),
                                                    )
                                                    : InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          ColorConstants
                                                              .failColor,
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 2,
                                                            horizontal: 5,
                                                          ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstants
                                                                  .failColor,
                                                        ),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstants
                                                                  .failColor,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstants
                                                                  .failColor,
                                                        ),
                                                      ),
                                                    )
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10.0),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "GRADE",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          ': ',
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: TextField(
                                              controller:
                                                  controller.gradeController,
                                              keyboardType:
                                                  TextInputType.number,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                      bottom: 4,
                                                    ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            ColorConstants
                                                                .labelColor,
                                                      ),
                                                    ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            ColorConstants
                                                                .labelColor,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),

                                          controller.gradeError.value.isNotEmpty
                                              ? Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 4.0,
                                                ),
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    controller.gradeError.value,
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 30.0),

                                  Text(
                                    'Communication Skills',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  Text(
                                    'Clear and effective communication',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.normal,
                                      color: ColorConstants.hintColor,
                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Very Poor',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Excellent',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SliderTheme(
                                    data: SliderThemeData(
                                      trackHeight: 3.0,
                                      valueIndicatorTextStyle: TextStyle(
                                        color: ColorConstants.whiteColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    child: Slider(
                                      value:
                                          controller.communicationScore.value,
                                      min: 0,
                                      max: 5,
                                      divisions: 5,
                                      activeColor:
                                          ColorConstants.sliderActiveColor,
                                      inactiveColor:
                                          ColorConstants.sliderInactiveColor,
                                      label:
                                          controller.communicationScore.value
                                              .toString(),
                                      onChanged: (value) {
                                        controller.communicationScore.value =
                                            value;
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),

                                  Text(
                                    'Knowledge Acquisition',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  Text(
                                    'Understanding and applying training materials',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.normal,
                                      color: ColorConstants.hintColor,
                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Very Low',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Very High',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SliderTheme(
                                    data: SliderThemeData(
                                      trackHeight: 3.0,
                                      valueIndicatorTextStyle: TextStyle(
                                        color: ColorConstants.whiteColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    child: Slider(
                                      value: controller.knowledgeScore.value,
                                      min: 0,
                                      max: 5,
                                      divisions: 5,
                                      activeColor:
                                          ColorConstants
                                              .sliderActiveColorSecondary,
                                      inactiveColor:
                                          ColorConstants.sliderInactiveColor,
                                      label:
                                          controller.knowledgeScore.value
                                              .toString(),
                                      onChanged: (value) {
                                        controller.knowledgeScore.value = value;
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),

                                  Text(
                                    'Active Participation',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  Text(
                                    'Engaging actively',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.normal,
                                      color: ColorConstants.hintColor,
                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Very Low',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Very High',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SliderTheme(
                                    data: SliderThemeData(
                                      trackHeight: 3.0,
                                      valueIndicatorTextStyle: TextStyle(
                                        color: ColorConstants.whiteColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    child: Slider(
                                      value:
                                          controller
                                              .activeParticipationScore
                                              .value,
                                      min: 0,
                                      max: 5,
                                      divisions: 5,
                                      activeColor:
                                          ColorConstants
                                              .sliderActiveColorTertiary,
                                      inactiveColor:
                                          ColorConstants.sliderInactiveColor,
                                      label:
                                          controller
                                              .activeParticipationScore
                                              .value
                                              .toString(),
                                      onChanged: (value) {
                                        controller
                                            .activeParticipationScore
                                            .value = value;
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),

                                  Text(
                                    'Provided Additional Information',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  TextFormField(
                                    controller:
                                        controller.additionalInfoController,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Enter any additional information here',
                                      hintStyle: TextStyle(
                                        color: ColorConstants.hintColor,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: ColorConstants.labelColor,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  controller
                                          .additionalInfoError
                                          .value
                                          .isNotEmpty
                                      ? Padding(
                                        padding: const EdgeInsets.only(
                                          top: 4.0,
                                        ),
                                        child: Text(
                                          controller.additionalInfoError.value,
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                      : const SizedBox.shrink(),

                                  CheckboxListTile(
                                    title: Text(
                                      'I agree with all of the results above',
                                    ),
                                    value: controller.isAgreed.value,
                                    onChanged: (value) {
                                      controller.isAgreed.value =
                                          value ?? false;

                                      if (value == true) {
                                        controller.agreeError.value = '';
                                      }
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    activeColor: ColorConstants.successColor,
                                    checkColor: ColorConstants.whiteColor,
                                  ),

                                  controller.agreeError.value.isNotEmpty
                                      ? Text(
                                        controller.agreeError.value,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      )
                                      : const SizedBox.shrink(),

                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        bool isValid = true;

                                        if (!controller.isAgreed.value) {
                                          controller.agreeError.value =
                                              'Please confirm your agreement first.';
                                          isValid = false;
                                        } else {
                                          controller.agreeError.value = '';
                                        }

                                        if (controller.gradeController.text
                                            .trim()
                                            .isEmpty) {
                                          controller.gradeError.value =
                                              'Grade is required.';
                                          isValid = false;
                                        } else {
                                          controller.gradeError.value = '';
                                        }

                                        if (controller
                                            .additionalInfoController
                                            .text
                                            .trim()
                                            .isEmpty) {
                                          controller.additionalInfoError.value =
                                              'Additional info is required.';
                                          isValid = false;
                                        } else {
                                          controller.additionalInfoError.value =
                                              '';
                                        }

                                        if (!isValid) return;

                                        var result = await controller.submitScore();

                                        if (result == true){
                                        QuickAlert.show(
                                          context: Get.context!,
                                          type: QuickAlertType.success,
                                          title: 'Success',
                                          text: 'Score submitted successfully!',
                                          confirmBtnText: 'OK',
                                          onConfirmBtnTap: () {
                                            Get.back();
                                            Get.back(result: true); // Navigate back to the previous screen
                                          },
                                        );
                                        } else {
                                          QuickAlert.show(
                                            context: Get.context!,
                                            type: QuickAlertType.error,
                                            title: 'Error',
                                            text: 'Failed to submit score.',
                                            confirmBtnText: 'OK',
                                          );
                                        }
                                      },

                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorConstants.successColor,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12.0,
                                          horizontal: 24.0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Submit Score',
                                        style: GoogleFonts.notoSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstants.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
