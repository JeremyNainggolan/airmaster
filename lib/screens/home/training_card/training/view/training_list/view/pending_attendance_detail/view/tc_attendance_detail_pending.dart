import 'package:airmaster/helpers/input_decoration.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/pending_attendance_detail/controller/tc_attendance_detail_pending_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TC_Attendance_Detail_Pending extends GetView<TC_AttendanceDetail_Pending_Controller> {
  const TC_Attendance_Detail_Pending({super.key});

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
      body: SingleChildScrollView(
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
                    initialValue: controller.attendanceData['subject'],
                    decoration: CustomInputDecoration.customInputDecorationReadOnly(labelText: 'Subject'),
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
                              DateTime.parse(controller.attendanceData['date']),
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
                    initialValue: controller.attendanceData['department'],
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
                    initialValue: controller.attendanceData['trainingType'],
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
              initialValue: controller.attendanceData['user_name'],
              decoration: CustomInputDecoration.customInputDecorationReadOnly(labelText:
                'Chair Person / Instructor',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20, // Ubah nilai ini untuk mengatur tinggi
                  horizontal: 12,
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextFormField(
              readOnly: true,
              enableInteractiveSelection: false,
              initialValue:
                  controller.attendanceParticipant.isEmpty
                      ? '0 Person '
                      : '${controller.attendanceParticipant.length.toString()} Person',
              style: TextStyle(fontWeight: FontWeight.bold),

              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 12,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConstants.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConstants.blackColor),
                ),
                labelStyle: TextStyle(color: ColorConstants.hintColor),
                floatingLabelStyle: TextStyle(color: ColorConstants.hintColor),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.person, color: ColorConstants.labelColor),
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
                  child:  ListTile(
                      leading: Icon(Icons.qr_code_2_rounded, size: 35),
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
                        size: 18,
                        color: ColorConstants.labelColor,
                      ),

                      onTap: () => {showBottomDialog()},
                    ),
                )
                : Card(
                  color: ColorConstants.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: ListTile(
                      leading: Icon(Icons.qr_code_2_rounded, size: 35),
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
          ],
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
