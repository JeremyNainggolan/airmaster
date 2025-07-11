import 'dart:math';

import 'package:airmaster/helpers/input_decoration.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_attendance_detail/controller/tc_attendance_detail_done_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
                              decoration: decorationReadOnly('Subject'),
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
                              decoration: decorationReadOnly('Date'),
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
                              decoration: decorationReadOnly('Department'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              initialValue: controller.attendanceData['venue'],
                              decoration: decorationReadOnly('Venue'),
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
                              decoration: decorationReadOnly('Training Type'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              initialValue: controller.attendanceData['room'],
                              decoration: decorationReadOnly('Room'),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        readOnly: true,
                        enableInteractiveSelection: false,
                        initialValue: controller.attendanceData['user_name'],
                        decoration: decorationReadOnly(
                          'Chair Person / Instructor',
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
                        initialValue:
                            '${controller.totalTrainee} Persons',
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
                    ],
                  ),
                ),
      ),
    );
  }
}
