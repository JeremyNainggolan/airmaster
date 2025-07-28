import 'dart:ui';

import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/screens/home/training_card/training_list/view/create_attendance/controller/examine_create_attendance_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class Examinee_CreateAttendance
    extends GetView<Examinee_CreateAttendance_Controller> {
  const Examinee_CreateAttendance({super.key});
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
            onPressed: () => Get.back(result: true),
          ),
          title: Text(
            'Create Attendance',
            style: GoogleFonts.notoSans(
              color: ColorConstants.whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
                                width: 100, 
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
                  ),

                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),

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
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Signature',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textTertiary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(
                            color: ColorConstants.dividerColor,
                            thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    SizeConstant.BORDER_RADIUS,
                                  ),
                                ),
                                child: SfSignaturePad(
                                  key: controller.signatureKey,
                                  backgroundColor: Colors.transparent,
                                  onDrawEnd: () async {
                                    final imageData =
                                        await controller
                                            .signatureKey
                                            .currentState!
                                            .toImage();
                                    final byteData = await imageData.toByteData(
                                      format: ImageByteFormat.png,
                                    );

                                    if (byteData != null) {
                                      controller.signatureImg =
                                          byteData.buffer.asUint8List();
                                    }
                                  },
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete_outline_outlined,
                                    size: 32,
                                    color: ColorConstants.primaryColor,
                                  ),
                                  onPressed: () {
                                    controller.signatureKey.currentState
                                        ?.clear();

                                    controller.signatureImg = null;
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(
                                  SizeConstant.PADDING_MIN,
                                ),
                                alignment: Alignment.topLeft,
                                child: Image.asset(
                                  'assets/images/airasia_logo_circle.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (controller.signatureImg == null) {
                                  ShowAlert.showErrorAlertWithoutLoading(
                                    Get.context!,
                                    'Signature Required',
                                    'Please provide your signature before proceeding.',
                                  );
                                  return;
                                }

                                final confirm = await ShowAlert.showConfirmAlert(
                                  Get.context!,
                                  'Confirm Handover',
                                  'Are you sure you want to hand over the device to the next FO?',
                                );

                                if (confirm == true) {
                                  QuickAlert.show(
                                    barrierDismissible: false,
                                    context: Get.context!,
                                    type: QuickAlertType.loading,
                                    text: 'Handing over...',
                                  );

                                  final success =
                                      await controller.createAttendance();

                                  if (Get.isDialogOpen ?? false) Get.back();

                                  if (success) {
                                    await ShowAlert.showFetchSuccess(
                                      Get.context!,
                                      'Success',
                                      'Device handover completed successfully.',
                                    );
                                    Get.back();
                                    Get.back(result: true);
                                  } else {
                                    await ShowAlert.showErrorAlert(
                                      Get.context!,
                                      'Error',
                                      'Failed to complete the handover. Please try again.',
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'Submit Attendance',
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textSecondary,
                                  fontSize: SizeConstant.TEXT_SIZE,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
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
