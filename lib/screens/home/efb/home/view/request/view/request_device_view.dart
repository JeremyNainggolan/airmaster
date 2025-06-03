// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:airmaster/helpers/qr_scanner.dart';
import 'package:airmaster/model/devices/device.dart';
import 'package:airmaster/screens/home/efb/home/view/request/controller/request_device_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/input_decoration.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

class Request_View extends GetView<Request_Controller> {
  const Request_View({super.key});

  @override
  Widget build(BuildContext context) {
    List<Device> searchedDevices = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () async {
            Get.back();
          },
        ),
        title: Text(
          "EFB | Request Device",
          style: GoogleFonts.notoSans(
            color: ColorConstants.textSecondary,
            fontSize: SizeConstant.SUB_HEADING_SIZE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
              child: Row(
                children: [
                  Expanded(
                    child: TypeAheadField<Device>(
                      controller: controller.requestDevice,
                      builder: (context, _, focusNode) {
                        return TextField(
                          onTap: () {
                            controller.selectedDevice.value = false;
                            controller.requestDevice.text = '';
                            controller.selectedDeviceNo.value = '';
                            controller.selectediOSVersion.value = '';
                            controller.selectedFlySmart.value = '';
                            controller.selectedDocuVersion.value = '';
                            controller.selectedLidoVersion.value = '';
                            controller.selectedHub.value = '';
                          },
                          controller: controller.requestDevice,
                          focusNode: focusNode,
                          decoration:
                              CustomInputDecoration.customInputDecorationWithPrefixIcon(
                                labelText: 'Search Device',
                                icon: Icon(Icons.device_hub),
                              ),
                          textInputAction: TextInputAction.next,
                        );
                      },
                      suggestionsCallback: (pattern) async {
                        Future.delayed(Duration(milliseconds: 500));
                        if (pattern.isNotEmpty) {
                          searchedDevices = await controller.getDeviceByName(
                            pattern,
                          );
                          return searchedDevices;
                        } else {
                          return [];
                        }
                      },
                      itemBuilder: (context, Device suggestion) {
                        return ListTile(
                          title: Text(
                            suggestion.deviceNo,
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          tileColor: ColorConstants.backgroundColor,
                        );
                      },
                      emptyBuilder: (context) {
                        return ListTile(
                          title: Text(
                            'No devices found',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          tileColor: ColorConstants.backgroundColor,
                        );
                      },
                      onSelected: (Device? suggestion) {
                        if (suggestion != null) {
                          controller.requestDevice.text = suggestion.deviceNo;
                          controller.selectedDevice.value = true;
                          controller.selectedDeviceNo.value =
                              suggestion.deviceNo;
                          controller.selectediOSVersion.value =
                              suggestion.iosVersion;
                          controller.selectedFlySmart.value =
                              suggestion.flySmart;
                          controller.selectedDocuVersion.value =
                              suggestion.docuVersion;
                          controller.selectedLidoVersion.value =
                              suggestion.lidoVersion;
                          controller.selectedHub.value = suggestion.hub;
                          log("Selected Device: ${suggestion.deviceNo}");
                        } else {
                          log("No device selected");
                        }
                      },
                      hideOnSelect: true,
                    ),
                  ),
                  SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          SizeConstant.BORDER_RADIUS,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      controller.selectedDevice.value = false;
                      controller.requestDevice.text = '';
                      controller.selectedDeviceNo.value = '';
                      controller.selectediOSVersion.value = '';
                      controller.selectedFlySmart.value = '';
                      controller.selectedDocuVersion.value = '';
                      controller.selectedLidoVersion.value = '';
                      controller.selectedHub.value = '';

                      final result = await Get.to(() => QrScanner());

                      if (result != null) {
                        var device = await controller.getDeviceById(result);

                        if (device != null) {
                          controller.selectedDevice.value = true;
                          controller.selectedDeviceNo.value = device.deviceNo;
                          controller.selectediOSVersion.value =
                              device.iosVersion;
                          controller.selectedFlySmart.value = device.flySmart;
                          controller.selectedDocuVersion.value =
                              device.docuVersion;
                          controller.selectedLidoVersion.value =
                              device.lidoVersion;
                          controller.selectedHub.value = device.hub;
                        } else {
                          Get.snackbar(
                            'Device Not Found',
                            'No device found for the scanned QR code.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: ColorConstants.primaryColor,
                            colorText: Colors.white,
                            duration: Duration(seconds: 3),
                            margin: EdgeInsets.all(12),
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConstant.VERTICAL_PADDING,
                      ),
                      child: Icon(
                        size: 35.0,
                        Icons.qr_code_scanner,
                        color: ColorConstants.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () =>
                  controller.selectedDevice.value
                      ? Padding(
                        padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConstants.tertiaryColor,
                            borderRadius: BorderRadius.circular(
                              SizeConstant.BORDER_RADIUS,
                            ),
                            border: Border.all(
                              color: ColorConstants.successColor,
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
                                  "Device Information",
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textPrimary,
                                    fontSize: SizeConstant.SUB_HEADING_SIZE,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                                Obx(
                                  () => buildInfoRow(
                                    "Device No",
                                    controller.selectedDeviceNo.value,
                                  ),
                                ),
                                Obx(
                                  () => buildInfoRow(
                                    "iOS Version",
                                    controller.selectediOSVersion.value,
                                  ),
                                ),
                                Obx(
                                  () => buildInfoRow(
                                    "Fly Smart Version",
                                    controller.selectedFlySmart.value,
                                  ),
                                ),
                                Obx(
                                  () => buildInfoRow(
                                    "Docunet Version",
                                    controller.selectedDocuVersion.value,
                                  ),
                                ),
                                Obx(
                                  () => buildInfoRow(
                                    "Lido mPilot Version",
                                    controller.selectedLidoVersion.value,
                                  ),
                                ),
                                Obx(
                                  () => buildInfoRow(
                                    "HUB",
                                    controller.selectedHub.value,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConstant.SIZED_BOX_HEIGHT_2,
                                ),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: double.infinity,
                                  lineThickness: 1.0,
                                  dashLength: 4.0,
                                  dashColor: Colors.grey,
                                  dashRadius: 0.0,
                                  dashGapLength: 4.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                                SizedBox(
                                  height: SizeConstant.SIZED_BOX_HEIGHT_2,
                                ),
                                Text(
                                  "Device Condition",
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textPrimary,
                                    fontSize: SizeConstant.SUB_HEADING_SIZE,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                                Text(
                                  "Provide information on the condition of the device received",
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textPrimary,
                                    fontSize: SizeConstant.TEXT_SIZE,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        "Category :",
                                        style: GoogleFonts.notoSans(
                                          color: ColorConstants.textPrimary,
                                          fontSize: SizeConstant.TEXT_SIZE_HINT,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => DropdownButton<String>(
                                        value: controller.category.value,
                                        underline: Container(),
                                        dropdownColor:
                                            ColorConstants.backgroundColor,
                                        onChanged: (value) {
                                          controller.category.value = value!;
                                          log("Selected Category: $value");
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
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant
                                                            .TEXT_SIZE_HINT,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                                TextField(
                                  onTap: () => controller.remark.value = '',
                                  onChanged: (value) {
                                    controller.remark.value = value;
                                  },
                                  decoration:
                                      CustomInputDecoration.customInputDecoration(
                                        labelText: 'Remarks',
                                      ),
                                  maxLines: 3,
                                ),
                                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _showConfirmationDialog(context);
                                    },
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                        EdgeInsets.symmetric(vertical: 12.0),
                                      ),
                                      backgroundColor: WidgetStateProperty.all(
                                        ColorConstants.primaryColor,
                                      ),
                                    ),
                                    child: Text(
                                      'Request',
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.textSecondary,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: ColorConstants.backgroundColor,
          shadowColor: ColorConstants.shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'Confirm Request',
            style: GoogleFonts.notoSans(
              color: ColorConstants.textPrimary,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to submit this request?',
            style: GoogleFonts.notoSans(
              color: ColorConstants.textPrimary,
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: GoogleFonts.notoSans(
                  color: ColorConstants.textPrimary,
                  fontSize: SizeConstant.TEXT_SIZE_HINT,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Yes',
                style: GoogleFonts.notoSans(
                  color: ColorConstants.textSecondary,
                  fontSize: SizeConstant.TEXT_SIZE_HINT,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () async {
                Navigator.of(dialogContext).pop();

                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.loading,
                  text: 'Submitting...',
                );

                var submitResult = await controller.submitRequest();
                log(submitResult.toString());

                if (Get.isDialogOpen ?? false) {
                  Get.back();
                }

                if (submitResult) {
                  QuickAlert.show(
                    barrierDismissible: false,
                    context: Get.context!,
                    type: QuickAlertType.success,
                    title: 'Success!',
                    text: 'Your request has been submitted successfully.',
                    confirmBtnTextStyle: GoogleFonts.notoSans(
                      color: ColorConstants.textSecondary,
                      fontSize: SizeConstant.TEXT_SIZE_HINT,
                      fontWeight: FontWeight.normal,
                    ),
                    onConfirmBtnTap: () async {
                      Get.back();
                      Get.back();
                      Get.back(result: true);
                    },
                  );
                } else {
                  QuickAlert.show(
                    context: Get.context!,
                    type: QuickAlertType.error,
                    title: 'Failed',
                    text: 'Failed to submit your request. Please try again.',
                    confirmBtnTextStyle: GoogleFonts.notoSans(
                      color: ColorConstants.textSecondary,
                      fontSize: SizeConstant.TEXT_SIZE_HINT,
                      fontWeight: FontWeight.normal,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 150, child: buildTextKey(label)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              ":",
              style: GoogleFonts.notoSans(color: ColorConstants.textPrimary),
            ),
          ),
          Expanded(child: buildTextValue(value.isNotEmpty ? value : "-")),
        ],
      ),
    );
  }

  Widget buildTextKey(String text) {
    return Text(
      text,
      style: GoogleFonts.notoSans(
        color: ColorConstants.textPrimary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget buildTextValue(String text) {
    return Text(
      text,
      textAlign: TextAlign.end,
      style: GoogleFonts.notoSans(
        color: ColorConstants.textPrimary,
        fontSize: SizeConstant.TEXT_SIZE,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
