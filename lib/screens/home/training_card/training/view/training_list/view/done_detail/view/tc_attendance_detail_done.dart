import 'dart:developer';

import 'package:airmaster/helpers/input_decoration.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/controller/tc_attendance_detail_done_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_Attendance_Detail_Done
    extends GetView<TC_AttendanceDetail_Done_Controller> {
  const TC_Attendance_Detail_Done({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () => Get.back(),
        ),
        title: Text('Attendance List'),
        titleTextStyle: GoogleFonts.notoSans(
          color: ColorConstants.textSecondary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              initialValue:
                                  controller.attendanceData['subject'],
                              decoration:
                                  CustomInputDecoration.customInputDecorationReadOnly(
                                    labelText: 'Subject',
                                  ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              initialValue:
                                  controller.attendanceData['date'] != null
                                      ? DateFormat('dd MMMM yyyy').format(
                                        DateTime.parse(
                                          controller.attendanceData['date'],
                                        ),
                                      )
                                      : 'No Date',
                              decoration:
                                  CustomInputDecoration.customInputDecorationReadOnly(
                                    labelText: 'Date',
                                  ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              initialValue:
                                  controller.attendanceData['department'],
                              decoration:
                                  CustomInputDecoration.customInputDecorationReadOnly(
                                    labelText: 'Department',
                                  ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              initialValue: controller.attendanceData['venue'],
                              decoration:
                                  CustomInputDecoration.customInputDecorationReadOnly(
                                    labelText: 'Venue',
                                  ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              initialValue:
                                  controller.attendanceData['trainingType'],
                              decoration:
                                  CustomInputDecoration.customInputDecorationReadOnly(
                                    labelText: 'Training Type',
                                  ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              initialValue: controller.attendanceData['room'],
                              decoration:
                                  CustomInputDecoration.customInputDecorationReadOnly(
                                    labelText: 'Room',
                                  ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        readOnly: true,
                        enableInteractiveSelection: false,
                        initialValue: controller.attendanceData['user_name'],
                        decoration:
                            CustomInputDecoration.customInputDecorationReadOnly(
                              labelText: 'Chair Person / Instructor',
                              contentPadding: const EdgeInsets.symmetric(
                                vertical:
                                    20, // Ubah nilai ini untuk mengatur tinggi
                                horizontal: 12,
                              ),
                            ),
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        readOnly: true,
                        enableInteractiveSelection: false,
                        initialValue:
                            '${controller.attendanceParticipant.length.toString()} Persons',
                        style: TextStyle(fontWeight: FontWeight.bold),

                        onTap:
                            () => Get.toNamed(
                              AppRoutes.ADMIN_TOTAL_TRAINEE,
                              arguments: {
                                'dataParticipant':
                                    controller.attendanceParticipant,
                                'totalTrainee':
                                    controller.attendanceParticipant.length
                                        .toString(),
                              },
                            ),

                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorConstants.borderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorConstants.blackColor,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: ColorConstants.hintColor,
                          ),
                          floatingLabelStyle: TextStyle(
                            color: ColorConstants.hintColor,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              Icons.person,
                              color: ColorConstants.labelColor,
                            ),
                          ),
                          labelText: 'Attendance',
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstants.hintColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        readOnly: true,
                        enableInteractiveSelection: false,
                        initialValue: '${controller.totalTrainee} Persons',
                        style: TextStyle(fontWeight: FontWeight.bold),

                        onTap:
                            () => Get.toNamed(
                              AppRoutes.TC_ABSENT_TRAINEE,
                              arguments: controller.attendanceData['_id'],
                            ),

                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorConstants.borderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorConstants.blackColor,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: ColorConstants.hintColor,
                          ),
                          floatingLabelStyle: TextStyle(
                            color: ColorConstants.hintColor,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              Icons.person_off,
                              color: ColorConstants.labelColor,
                            ),
                          ),
                          labelText: 'Absent Trainees',
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstants.hintColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 30,
                            child: ElevatedButton.icon(
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
                                  String exportedPDFPath =
                                      await controller
                                          .eksportAttendanceListPDF();
                                  if (exportedPDFPath.isNotEmpty) {
                                    await controller.openExportedPDF(
                                      exportedPDFPath,
                                    );
                                  }
                                } catch (e) {
                                  log('Error: $e');
                                } finally {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              icon: Icon(
                                Icons.print,
                                color: ColorConstants.textSecondary,
                              ),
                              label: Text(
                                "Save PDF",
                                style: GoogleFonts.notoSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.textSecondary,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.pdfColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
