import 'dart:ui';

import 'package:airmaster/helpers/input_decoration.dart';
import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/confirm_detail/controller/tc_attendance_detail_confirm_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class TC_Attendance_Detail_Confirm
    extends GetView<TC_AttendanceDetail_Confirm_Controller> {
  const TC_Attendance_Detail_Confirm({super.key});

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
                              decoration: CustomInputDecoration.customInputDecorationReadOnly(labelText:'Subject'),
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
                              decoration: CustomInputDecoration.customInputDecorationReadOnly(labelText:'Date'),
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
                              decoration: CustomInputDecoration.customInputDecorationReadOnly(labelText:'Department'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              initialValue: controller.attendanceData['venue'],
                              decoration: CustomInputDecoration.customInputDecorationReadOnly(labelText:'Venue'),
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
                              decoration: CustomInputDecoration.customInputDecorationReadOnly(labelText:'Training Type'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              initialValue: controller.attendanceData['room'],
                              decoration: CustomInputDecoration.customInputDecorationReadOnly(labelText:'Room'),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        readOnly: true,
                        enableInteractiveSelection: false,
                        initialValue: controller.attendanceData['user_loaNo'],
                        decoration: CustomInputDecoration.customInputDecorationReadOnly(labelText:
                          'LOA NO',
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
                        initialValue: controller.attendanceData['user_name'],
                        decoration: CustomInputDecoration.customInputDecorationReadOnly(labelText:
                          'Chair Person / Instructor',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical:
                                20, // Ubah nilai ini untuk mengatur tinggi
                            horizontal: 12,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Text(
                        'Meeting / Training',
                        style: TextStyle(
                          color: ColorConstants.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: "Meeting",
                                  groupValue: controller.selectedOption.value,
                                  onChanged: null,
                                ),
                                Text("Meeting"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'Training',
                                  groupValue: controller.selectedOption.value,
                                  onChanged: null,
                                ),
                                Text("Training"),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        enableInteractiveSelection: false,
                        initialValue:
                            '${controller.attendanceParticipant.length} Persons',
                        style: TextStyle(fontWeight: FontWeight.bold),

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
                          labelText: 'Present Trainees',
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstants.hintColor,
                              size: 15,
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.ADMIN_TOTAL_TRAINEE,
                            arguments: {
                              'dataParticipant':
                                  controller.attendanceParticipant,
                              'totalTrainee':
                                  controller.attendanceParticipant.length
                                      .toString(),
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      TypeAheadField<Trainee>(
                        controller: controller.traineesController,
                        decorationBuilder: (context, child) {
                          return Material(
                            elevation: 4,
                            color: ColorConstants.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                            child: child,
                          );
                        },
                        builder: (context, textController, focusNode) {
                          return TextFormField(
                            controller: textController,
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                              labelText: 'Absent Trainee',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select user by finding name';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          );
                        },
                        suggestionsCallback: (pattern) async {
                          return await controller.getInstructorSuggestions(
                            pattern,
                          );
                        },
                        itemBuilder: (context, Trainee suggestion) {
                          return ListTile(
                            textColor: ColorConstants.backgroundColor,
                            title: Text(
                              '${suggestion.name} (${suggestion.id})',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        emptyBuilder: (context) {
                          return ListTile(
                            title: Text(
                              'No users found.',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        onSelected: (Trainee suggestion) {
                          final alreadyExists = controller.listSelectedTrainees
                              .any((trainee) => trainee.id == suggestion.id);

                          if (!alreadyExists) {
                            controller.listSelectedTrainees.add(suggestion);
                          }

                          // controller.traineesController.clear();
                        },
                      ),

                      controller.listSelectedTrainees.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                controller.listSelectedTrainees.map((trainee) {
                                  return Card(
                                    color: ColorConstants.backgroundColor,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        '${trainee.name} ( ${trainee.id} )',
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          controller.listSelectedTrainees
                                              .remove(trainee);
                                        },
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),

                      const SizedBox(height: 10),
                      Text(
                        'Class Pasword',
                        style: TextStyle(
                          color: ColorConstants.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                      const SizedBox(height: 10),

                      controller.attendanceData['keyAttendance'] != null
                          ? Card(
                            color: ColorConstants.backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 12.0,
                              ),
                              child: ListTile(
                                leading: Icon(
                                  Icons.qr_code_2_rounded,
                                  size: 35,
                                ),
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  'Open QR Code',
                                  style: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '${controller.attendanceData['keyAttendance'] ?? 'No Password'}',
                                  style: TextStyle(
                                    color: ColorConstants.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                  color: ColorConstants.hintColor,
                                ),

                                onTap: () => {showBottomDialog()},
                              ),
                            ),
                          )
                          : Card(
                            color: ColorConstants.backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 12.0,
                              ),
                              child: ListTile(
                                leading: Icon(
                                  Icons.qr_code_2_rounded,
                                  size: 35,
                                ),
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  'Open QR Code',
                                  style: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'No Password',
                                  style: TextStyle(
                                    color: ColorConstants.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                      const SizedBox(height: 10),

                      const SizedBox(height: 20),

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
                                        final byteData = await imageData
                                            .toByteData(
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
                                          MediaQuery.of(context).size.width *
                                          0.1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                              'Confirm Attendance',
                              'Are you sure to submit this form?',
                            );

                            if (confirm == true) {
                              QuickAlert.show(
                                barrierDismissible: false,
                                context: Get.context!,
                                type: QuickAlertType.loading,
                                text: 'Submitting...',
                              );

                              final success =
                                  await controller.confirmClassAttendance();

                              if (success) {
                                await ShowAlert.showSuccessAlert(
                                  Get.context!,
                                  'Success',
                                  'Attendance submitted successfully.',
                                );
                              } else {
                                await ShowAlert.showErrorAlert(
                                  Get.context!,
                                  'Error',
                                  'Failed to complete the attendance. Please try again.',
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
    );
  }

  Widget generateQRCode() {
    final keyAttendance = controller.attendanceData['keyAttendance'];

    return QrImageView(
      data: keyAttendance,
      version: QrVersions.auto,
      size: 180.0,
      gapless: false,
      embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
      foregroundColor: ColorConstants.blackColor,
      backgroundColor: ColorConstants.whiteColor,
    );
  }

  Widget addAirAsiaLogoToQRCode() {
    return Container(
      width: 180.0,
      height: 180.0,
      child: Stack(
        children: [
          generateQRCode(),
          Center(
            child: Image.asset(
              'assets/images/airasia_logo_circle.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }

  void showBottomDialog() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: Get.width,
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: ColorConstants.whiteColor,
            ),
            child: Column(
              children: [
                Text(
                  "QR Code",
                  style: GoogleFonts.notoSans(
                    fontSize: SizeConstant.TEXT_SIZE,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textPrimary,
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                addAirAsiaLogoToQRCode(),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                Text(
                  "SCAN ME",
                  style: GoogleFonts.notoSans(
                    fontSize: SizeConstant.TEXT_SIZE_HINT,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textTertiary,
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_DOUBLE),
              ],
            ),
          ),
        );
      },
    );
  }
}
