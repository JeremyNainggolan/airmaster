import 'dart:developer';

import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/view/tc_pilot_training_history/view/tc_detail_pilot_histroy/controller/tc_detail_pilot_history_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_Detail_PilotHistory
    extends GetView<TC_Detail_PilotHistory_Controller> {
  const TC_Detail_PilotHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Detail Training History',
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 50, child: Text(': ')),

                            Expanded(
                              child: Text(
                                "${controller.historyTraining['history_subject']}",
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 50, child: Text(': ')),

                            Expanded(
                              child: Text(
                                "${controller.historyTraining['history_department']}",
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 50, child: Text(': ')),

                            Expanded(
                              child: Text(
                                "${controller.historyTraining['history_training_type']}",
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 50, child: Text(': ')),

                            Expanded(
                              child: Text(
                                controller.historyTraining['history_date'] !=
                                        null
                                    ? DateFormat('dd MMMM yyyy').format(
                                      DateTime.parse(
                                        controller
                                            .historyTraining['history_date'],
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 50, child: Text(': ')),

                            Expanded(
                              child: Text(
                                "${controller.historyTraining['history_venue']}",
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 50, child: Text(': ')),

                            Expanded(
                              child: Text(
                                "${controller.historyTraining['history_room']}",
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 50, child: Text(': ')),

                            Expanded(
                              child: Text("${controller.instructorName}"),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),

                SizedBox(
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
                    child: const Text("Download Certificate"),
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
