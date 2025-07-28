import 'package:airmaster/screens/home/training_card/home/home_examinee/view/feedback/view/examinee_feedback/controller/tc_examinee_feedback_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class TC_ExamineeFeedback extends GetView<TC_ExamineeFeedback_Controller> {
  const TC_ExamineeFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Feedback Form',
          style: GoogleFonts.notoSans(
            color: ColorConstants.textSecondary,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.activeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    'Give Feedback!',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.successColor,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 10.0),

                  Text(
                    'Teaching Methods',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 5.0),

                  Text(
                    'Effective teaching metchod',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      color: ColorConstants.hintColor,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 10.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Ineffective', style: TextStyle(fontSize: 12)),
                      Text('Effective', style: TextStyle(fontSize: 12)),
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
                      value: controller.teachingMethodScore.value,
                      min: 0,
                      max: 5,
                      divisions: 5,
                      activeColor: ColorConstants.sliderActiveColor,
                      inactiveColor: ColorConstants.sliderInactiveColor,
                      label: controller.teachingMethodScore.value.toString(),
                      onChanged: (value) {
                        controller.teachingMethodScore.value = value;
                      },
                    ),
                  ),

                  const SizedBox(height: 10.0),

                  Text(
                    'Mastery of Subject Matter',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 5.0),

                  Text(
                    'Proficient in delivering content',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      color: ColorConstants.hintColor,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 10.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Limited', style: TextStyle(fontSize: 12)),
                      Text('Exceptional', style: TextStyle(fontSize: 12)),
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
                      value: controller.masteryScore.value,
                      min: 0,
                      max: 5,
                      divisions: 5,
                      activeColor: ColorConstants.sliderActiveColorSecondary,
                      inactiveColor: ColorConstants.sliderInactiveColor,
                      label: controller.masteryScore.value.toString(),
                      onChanged: (value) {
                        controller.masteryScore.value = value;
                      },
                    ),
                  ),

                  const SizedBox(height: 10.0),

                  Text(
                    'Time Management',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 5.0),

                  Text(
                    'Efficient time use',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      color: ColorConstants.hintColor,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 10.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Poor', style: TextStyle(fontSize: 12)),
                      Text('Excellent', style: TextStyle(fontSize: 12)),
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
                      value: controller.timeManagementScore.value,
                      min: 0,
                      max: 5,
                      divisions: 5,
                      activeColor: ColorConstants.sliderActiveColorTertiary,
                      inactiveColor: ColorConstants.sliderInactiveColor,
                      label: controller.timeManagementScore.value.toString(),
                      onChanged: (value) {
                        controller.timeManagementScore.value = value;
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
                    controller: controller.additionalInfoController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter any additional information here',
                      hintStyle: TextStyle(color: ColorConstants.hintColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: ColorConstants.labelColor,
                        ),
                      ),
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                  if (controller.additionalInfoError.value.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        controller.additionalInfoError.value,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),

                  const SizedBox(height: 10.0),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.additionalInfoController.text
                            .trim()
                            .isEmpty) {
                          controller.additionalInfoError.value =
                              'Additional info is required.';
                        } else {
                          controller.additionalInfoError.value = '';
                        }

                        final valid = await controller.submitFeedback();
                        if (valid) {
                          QuickAlert.show(
                            context: Get.context!,
                            type: QuickAlertType.success,
                            title: 'Feedback Submitted',
                            text:
                                'Your feedback has been successfully submitted.',
                            confirmBtnText: 'OK',
                            onConfirmBtnTap: () {
                              Get.back();
                              Get.back(result: true); // Navigate back to the previous screen
                            },
                          );
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.successColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Submit Feedback',
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
          ),
        ),
      ),
    );
  }
}
