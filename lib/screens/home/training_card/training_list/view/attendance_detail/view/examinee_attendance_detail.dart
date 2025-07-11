import 'package:airmaster/screens/home/training_card/training_list/view/attendance_detail/controller/examinee_attendance_detail_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Examinee_AttendanceDetail extends GetView<Examinee_AttendanceDetail_Controller> {
  const Examinee_AttendanceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) {
          Get.back(result: true);
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          title: Text('Attendance Detail', style: GoogleFonts.notoSans(
            color: ColorConstants.textSecondary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
              onPressed: () => Get.back(result: true),
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
                                  "${controller.attendanceData['subject']}",
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
                                  "${controller.attendanceData['department']}",
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
                                  "${controller.attendanceData['trainingType']}",
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
                                  controller.attendanceData['date'] != null
                                      ? DateFormat('dd MMMM yyyy').format(
                                        DateTime.parse(
                                          controller.attendanceData['date'],
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
                                  "${controller.attendanceData['venue']}",
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
                                  "${controller.attendanceData['room']}",
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
                                child: Text(
                                  "${controller.attendanceData['instructor_name']}",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),]))
          )
      ),
    ),
    );
  }
}