import 'dart:ui';

import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/screens/home/efb/home/view/occ-pages/return/controller/occ_returned_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:airmaster/widgets/build_row.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:airmaster/widgets/input_decoration.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class OCC_Returned_View extends GetView<OCC_Returned_Controller> {
  const OCC_Returned_View({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
            onPressed: () async {
              Get.back();
            },
          ),
          title: Text(
            "EFB | Returned Device",
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: SizeConstant.SUB_HEADING_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: ColorConstants.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
            child: Column(
              children: [
                controller.device['isFoRequest']
                    ? Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.tertiaryColor,
                        borderRadius: BorderRadius.circular(
                          SizeConstant.BORDER_RADIUS,
                        ),
                        border: Border.all(color: ColorConstants.successColor),
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
                              "Main Device Information",
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.SUB_HEADING_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                            BuildRow(
                              label: "Device No",
                              value: controller.device['mainDeviceNo'],
                            ),
                            BuildRow(
                              label: "iOS Version",
                              value: controller.device['mainDeviceiOSVersion'],
                            ),
                            BuildRow(
                              label: "Fly Smart Version",
                              value: controller.device['mainDeviceFlySmart'],
                            ),
                            BuildRow(
                              label: "Docunet Version",
                              value: controller.device['mainDeviceDocuVersion'],
                            ),
                            BuildRow(
                              label: "Lido mPilot Version",
                              value: controller.device['mainDeviceLidoVersion'],
                            ),
                            BuildRow(
                              label: "Hub",
                              value: controller.device['mainDeviceHub'],
                            ),
                            BuildRow(
                              label: "Category",
                              value: controller.device['mainDeviceCategory'],
                            ),
                            BuildRow(
                              label: "Remark",
                              value:
                                  controller.device['mainDeviceRemark'] ?? '-',
                            ),
                            CustomDivider(divider: 'Backup Device Information'),
                            Text(
                              "Backup Device Information",
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.SUB_HEADING_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                            BuildRow(
                              label: "Device No",
                              value: controller.device['backupDeviceNo'],
                            ),
                            BuildRow(
                              label: "iOS Version",
                              value:
                                  controller.device['backupDeviceiOSVersion'],
                            ),
                            BuildRow(
                              label: "Fly Smart Version",
                              value: controller.device['backupDeviceFlySmart'],
                            ),
                            BuildRow(
                              label: "Docunet Version",
                              value:
                                  controller.device['backupDeviceDocuVersion'],
                            ),
                            BuildRow(
                              label: "Lido mPilot Version",
                              value:
                                  controller.device['backupDeviceLidoVersion'],
                            ),
                            BuildRow(
                              label: "Hub",
                              value: controller.device['backupDeviceHub'],
                            ),
                            BuildRow(
                              label: "Category",
                              value: controller.device['backupDeviceCategory'],
                            ),
                            BuildRow(
                              label: "Remark",
                              value:
                                  controller.device['backupDeviceRemark'] ??
                                  '-',
                            ),
                            CustomDivider(divider: 'Request by'),
                            BuildRow(
                              label: "ID",
                              value: controller.device['request_user'],
                            ),
                            BuildRow(
                              label: "Name",
                              value: controller.device['request_user_name'],
                            ),
                            BuildRow(
                              label: "Status",
                              value:
                                  controller.device['status'].toString() ==
                                          'occ_returned'
                                      ? 'Waiting for OCC Confirmation'
                                      : '',
                            ),
                            BuildRow(
                              label: "Date",
                              value: DateFormatter.convertDateTimeDisplay(
                                controller.device['request_date'],
                                "d MMMM yyyy",
                              ),
                            ),
                            CustomDivider(divider: 'Device Condition'),
                            Text(
                              'Here you can explain the condition of the device you received',
                              style: GoogleFonts.notoSans(
                                fontStyle: FontStyle.italic,
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    "Category",
                                    style: GoogleFonts.notoSans(
                                      color: ColorConstants.textPrimary,
                                      fontSize: SizeConstant.TEXT_SIZE_HINT,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: controller.category.value,
                                  underline: Container(),
                                  dropdownColor: ColorConstants.backgroundColor,
                                  onChanged: (value) {
                                    controller.category.value = value!;
                                  },
                                  borderRadius: BorderRadius.circular(
                                    SizeConstant.BORDER_RADIUS,
                                  ),
                                  items:
                                      <String>[
                                        'Good',
                                        'Good With Remarks',
                                        'Unserviceable',
                                      ].map<DropdownMenuItem<String>>((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.notoSans(
                                              color: ColorConstants.textPrimary,
                                              fontSize:
                                                  SizeConstant.TEXT_SIZE_HINT,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ],
                            ),
                            TextField(
                              onTap: () => controller.remark.value = '',
                              onChanged: (value) {
                                controller.remark.value = value;
                              },
                              decoration:
                                  CustomInputDecoration.customInputDecoration(
                                    labelText: 'Remarks',
                                  ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.tertiaryColor,
                        borderRadius: BorderRadius.circular(
                          SizeConstant.BORDER_RADIUS,
                        ),
                        border: Border.all(color: ColorConstants.successColor),
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
                              "Device Information",
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.SUB_HEADING_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                            BuildRow(
                              label: "Device No",
                              value: controller.device['deviceno'],
                            ),
                            BuildRow(
                              label: "iOS Version",
                              value: controller.device['ios_version'],
                            ),
                            BuildRow(
                              label: "Fly Smart Version",
                              value: controller.device['fly_smart'],
                            ),
                            BuildRow(
                              label: "Lido mPilot Version",
                              value: controller.device['lido_version'],
                            ),
                            BuildRow(
                              label: "Hub",
                              value: controller.device['hub'],
                            ),
                            BuildRow(
                              label: "Category",
                              value: controller.device['category'],
                            ),
                            BuildRow(
                              label: "Remark",
                              value: controller.device['remark'] ?? '-',
                            ),
                            CustomDivider(divider: 'Request by'),
                            BuildRow(
                              label: "ID",
                              value: controller.device['request_user'],
                            ),
                            BuildRow(
                              label: "Name",
                              value: controller.device['request_user_name'],
                            ),
                            BuildRow(
                              label: "Status",
                              value:
                                  controller.device['status'].toString() ==
                                          'occ_returned'
                                      ? 'Waiting for OCC Confirmation'
                                      : '',
                            ),
                            BuildRow(
                              label: "Date",
                              value: DateFormatter.convertDateTimeDisplay(
                                controller.device['request_date'],
                                "d MMMM yyyy",
                              ),
                            ),
                            CustomDivider(divider: 'Device Condition'),
                            Text(
                              'Here you can explain the condition of the device you received',
                              style: GoogleFonts.notoSans(
                                fontStyle: FontStyle.italic,
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    "Category",
                                    style: GoogleFonts.notoSans(
                                      color: ColorConstants.textPrimary,
                                      fontSize: SizeConstant.TEXT_SIZE_HINT,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: controller.category.value,
                                  underline: Container(),
                                  dropdownColor: ColorConstants.backgroundColor,
                                  onChanged: (value) {
                                    controller.category.value = value!;
                                  },
                                  borderRadius: BorderRadius.circular(
                                    SizeConstant.BORDER_RADIUS,
                                  ),
                                  items:
                                      <String>[
                                        'Good',
                                        'Good With Remarks',
                                        'Unserviceable',
                                      ].map<DropdownMenuItem<String>>((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.notoSans(
                                              color: ColorConstants.textPrimary,
                                              fontSize:
                                                  SizeConstant.TEXT_SIZE_HINT,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ],
                            ),
                            TextField(
                              onTap: () => controller.remark.value = '',
                              onChanged: (value) {
                                controller.remark.value = value;
                              },
                              decoration:
                                  CustomInputDecoration.customInputDecoration(
                                    labelText: 'Remarks',
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.tertiaryColor,
                    borderRadius: BorderRadius.circular(
                      SizeConstant.BORDER_RADIUS,
                    ),
                    border: Border.all(
                      color: ColorConstants.blackColor,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                                backgroundColor: Colors.white,
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
                                  controller.signatureKey.currentState?.clear();

                                  controller.signatureImg = null;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(SizeConstant.PADDING_MIN),
                              alignment: Alignment.topLeft,
                              child: Image.asset(
                                'assets/images/airasia_logo_circle.png',
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(SizeConstant.PADDING),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.errorColor,
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () async {
              if (controller.signatureImg == null) {
                ShowAlert.showErrorAlertWithoutLoading(
                  Get.context!,
                  'Signature Required',
                  'Please provide your signature before proceeding.',
                );
                return;
              }

              if (controller.isCaptured.value) {
                final isConfirmed = await ShowAlert.showConfirmAlert(
                  Get.context!,
                  'Confirm Return',
                  'Are you sure you want to confirm the return of this device?',
                );

                if (isConfirmed == true) {
                  ShowAlert.showLoadingAlert(Get.context!, 'Please wait...');

                  final isSuccess = await controller.returnOCC();

                  if (isSuccess) {
                    if (Get.isDialogOpen ?? false) Get.back();

                    await ShowAlert.showSuccessAlert(
                      Get.context!,
                      'Return Confirmed',
                      'The device return has been successfully confirmed.',
                    );
                  } else {
                    ShowAlert.showErrorAlert(
                      Get.context!,
                      'Return Failed',
                      'Failed to confirm the return of the device. Please try again.',
                    );
                  }
                }
                return;
              }

              controller.getImageFromCamera();
            },
            child: Text(
              controller.isCaptured.value ? 'Submit' : 'Capture Device',
              style: GoogleFonts.notoSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
