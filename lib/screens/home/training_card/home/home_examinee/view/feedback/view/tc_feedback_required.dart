import 'dart:developer';

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/home/home_examinee/view/feedback/controller/tc_feedback_required_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_FeedbackRequired extends GetView<TC_FeedbackRequired_Controller> {
  const TC_FeedbackRequired({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        title: Obx(
          () => Text(
            '${controller.historyTraining['detail_subject']} Training ',
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: ColorConstants.activeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () =>
            controller.isLoading.value
                ? Center(
                  child: LoadingAnimationWidget.hexagonDots(
                    color: ColorConstants.primaryColor,
                    size: 48,
                  ),
                )
                : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Congratulations!',
                          style: GoogleFonts.poppins(
                            color: ColorConstants.textPrimary,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Congratulations for passing the training',
                          style: GoogleFonts.poppins(
                            color: ColorConstants.textPrimary,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        controller.historyTraining['feedbackForInstructor'] ==
                                null
                            ? SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        log('${controller.historyTraining['feedbackForInstructor']}');
                                        final result = await Get.toNamed(
                                          AppRoutes.TC_EXAMINEE_GIVE_FEEDBACK,
                                          arguments: controller.historyTraining,
                                        );
                                        if (result == true) {
                                          await controller.needFeedback();
                                          controller.historyTraining.refresh();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            ColorConstants.successColor,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12.0,
                                        ),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20.0),
                                            bottomRight: Radius.circular(20.0),
                                            topLeft: Radius.circular(20.0),
                                            bottomLeft: Radius.circular(20.0),
                                          ),
                                          side: BorderSide(
                                            color: Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: const Text("Give Feedback"),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return LoadingAnimationWidget.hexagonDots(
                                          color: ColorConstants.activeColor,
                                          size: 48,
                                        );
                                      },
                                    );
                                    await controller.openExportedPDF(
                                      await controller.createCertificate(),
                                    );
                                  } catch (e) {
                                    log('Error: $e');
                                  } finally {
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: ColorConstants.successColor,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 1.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(20.0),
                                      bottomLeft: const Radius.circular(20.0),
                                      topRight: const Radius.circular(20.0),
                                      bottomRight: const Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text("Download Certificate")],
                                ),
                              ),
                            ),

                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorConstants.tertiaryColor,
                            borderRadius: BorderRadius.circular(
                              SizeConstant.BORDER_RADIUS,
                            ),
                            border: Border.all(
                              color: ColorConstants.borderColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100, // lebar tetap agar sejajar
                                      child: Text(
                                        "Subject",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50, child: Text(': ')),

                                    Expanded(
                                      child: Text(
                                        "${controller.historyTraining['detail_subject']}",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100, // lebar tetap agar sejajar
                                      child: Text(
                                        "Department",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50, child: Text(': ')),

                                    Expanded(
                                      child: Text(
                                        "${controller.historyTraining['detail_department']}",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100, // lebar tetap agar sejajar
                                      child: Text(
                                        "Training Type",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50, child: Text(': ')),

                                    Expanded(
                                      child: Text(
                                        "${controller.historyTraining['detail_trainingType']}",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100, // lebar tetap agar sejajar
                                      child: Text(
                                        "Date",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50, child: Text(': ')),

                                    Expanded(
                                      child: Text(
                                        controller.historyTraining['detail_date'] !=
                                                null
                                            ? DateFormat('dd MMMM yyyy').format(
                                              DateTime.parse(
                                                controller
                                                    .historyTraining['detail_date'],
                                              ),
                                            )
                                            : '',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100, // lebar tetap agar sejajar
                                      child: Text(
                                        "Venue",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50, child: Text(': ')),

                                    Expanded(
                                      child: Text(
                                        "${controller.historyTraining['detail_venue']}",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100, // lebar tetap agar sejajar
                                      child: Text(
                                        "Room",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50, child: Text(': ')),

                                    Expanded(
                                      child: Text(
                                        "${controller.historyTraining['detail_room']}",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100, // lebar tetap agar sejajar
                                      child: Text(
                                        "Instructor",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50, child: Text(': ')),

                                    Expanded(
                                      child: Text(
                                        "${controller.historyTraining['instructor_name'][0] ?? ''}",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
