import 'package:airmaster/helpers/qr_scanner.dart';
import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/model/devices/device.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/request/controller/fo_request_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/build_row.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:airmaster/widgets/input_decoration.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

class Fo_Request_View extends GetView<Fo_Request_Controller> {
  const Fo_Request_View({super.key});

  @override
  Widget build(BuildContext context) {
    List<Device> searchedDevices = [];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () async {
            Get.back();
          },
        ),
        title: Text(
          "EFB | FO Request Device",
          style: GoogleFonts.notoSans(
            color: ColorConstants.textSecondary,
            fontSize: SizeConstant.SUB_HEADING_SIZE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      body: Obx(
        () => ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: SizeConstant.SCREEN_PADDING,
                right: SizeConstant.SCREEN_PADDING,
                top: SizeConstant.SCREEN_PADDING,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TypeAheadField<Device>(
                      controller: controller.searchMainDevice,
                      builder: (context, _, focusNode) {
                        return TextField(
                          onTap: () {
                            controller.clearMainDevice();
                          },
                          controller: controller.searchMainDevice,
                          focusNode: focusNode,
                          decoration:
                              CustomInputDecoration.customInputDecorationWithPrefixIcon(
                                labelText: 'Search Main Device',
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
                      onSelected: (Device? suggestion) async {
                        if (suggestion != null) {
                          if (controller.backupDeviceNo.value ==
                              suggestion.deviceNo) {
                            return QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Error',
                              text:
                                  'Main device cannot be the same as backup device.',
                            );
                          }
                          controller.setMainDevice(suggestion);
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
                      controller.clearMainDevice();
                      final result = await Get.to(() => QrScanner());

                      if (result != null) {
                        var device = await controller.getDeviceById(result);

                        if (device != null) {
                          controller.setMainDevice(device);
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
            controller.mainDevice.value
                ? Padding(
                  padding: EdgeInsets.only(
                    left: SizeConstant.SCREEN_PADDING,
                    right: SizeConstant.SCREEN_PADDING,
                    top: SizeConstant.SCREEN_PADDING,
                  ),
                  child: Container(
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
                            value: controller.mainDeviceNo.value,
                          ),
                          BuildRow(
                            label: "iOS Version",
                            value: controller.mainDeviceiOSVersion.value,
                          ),
                          BuildRow(
                            label: "Fly Smart Version",
                            value: controller.mainDeviceFlySmart.value,
                          ),
                          BuildRow(
                            label: "Docunet Version",
                            value: controller.mainDeviceDocuVersion.value,
                          ),
                          BuildRow(
                            label: "Lido mPilot Version",
                            value: controller.mainDeviceLidoVersion.value,
                          ),
                          BuildRow(
                            label: "HUB",
                            value: controller.mainDeviceHub.value,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),
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
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),
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
                              DropdownButton<String>(
                                value: controller.mainDeviceCategory.value,
                                underline: Container(),
                                dropdownColor: ColorConstants.backgroundColor,
                                onChanged: (value) {
                                  controller.mainDeviceCategory.value = value!;
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
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          TextField(
                            onTap: () => controller.mainDeviceRemark.value = '',
                            onChanged: (value) {
                              controller.mainDeviceRemark.value = value;
                            },
                            decoration:
                                CustomInputDecoration.customInputDecoration(
                                  labelText: 'Remarks',
                                ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : Center(
                  child: Padding(
                    padding: EdgeInsets.all(SizeConstant.PADDING),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/images/search_empty.png'),
                          width: 250,
                        ),
                        Text(
                          'No Main Device Selected',
                          style: GoogleFonts.notoSans(
                            fontStyle: FontStyle.italic,
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE_HINT,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            CustomDivider(divider: 'Backup Device'),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConstant.SCREEN_PADDING,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TypeAheadField<Device>(
                      controller: controller.searchBackupDevice,
                      builder: (context, _, focusNode) {
                        return TextField(
                          onTap: () {
                            controller.clearBackupDevice();
                          },
                          controller: controller.searchBackupDevice,
                          focusNode: focusNode,
                          decoration:
                              CustomInputDecoration.customInputDecorationWithPrefixIcon(
                                labelText: 'Search Backup Device',
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
                      onSelected: (Device? suggestion) async {
                        if (suggestion != null) {
                          if (controller.mainDeviceNo.value ==
                              suggestion.deviceNo) {
                            return QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Error',
                              text:
                                  'Backup device cannot be the same as main device.',
                            );
                          }
                          controller.setBackupDevice(suggestion);
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
                      controller.clearBackupDevice();
                      final result = await Get.to(() => QrScanner());

                      if (result != null) {
                        var device = await controller.getDeviceById(result);

                        if (device != null) {
                          controller.setBackupDevice(device);
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
            controller.backupDevice.value
                ? Padding(
                  padding: EdgeInsets.only(
                    left: SizeConstant.SCREEN_PADDING,
                    right: SizeConstant.SCREEN_PADDING,
                    top: SizeConstant.SCREEN_PADDING,
                  ),
                  child: Container(
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
                            value: controller.backupDeviceNo.value,
                          ),
                          BuildRow(
                            label: "iOS Version",
                            value: controller.backupDeviceiOSVersion.value,
                          ),
                          BuildRow(
                            label: "Fly Smart Version",
                            value: controller.backupDeviceFlySmart.value,
                          ),
                          BuildRow(
                            label: "Docunet Version",
                            value: controller.backupDeviceDocuVersion.value,
                          ),
                          BuildRow(
                            label: "Lido mPilot Version",
                            value: controller.backupDeviceLidoVersion.value,
                          ),
                          BuildRow(
                            label: "HUB",
                            value: controller.backupDeviceHub.value,
                          ),
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),
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
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),
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
                              DropdownButton<String>(
                                value: controller.backupDeviceCategory.value,
                                underline: Container(),
                                dropdownColor: ColorConstants.backgroundColor,
                                onChanged: (value) {
                                  controller.backupDeviceCategory.value =
                                      value!;
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
                          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                          TextField(
                            onTap:
                                () => controller.backupDeviceRemark.value = '',
                            onChanged: (value) {
                              controller.backupDeviceRemark.value = value;
                            },
                            decoration:
                                CustomInputDecoration.customInputDecoration(
                                  labelText: 'Remarks',
                                ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : Center(
                  child: Padding(
                    padding: EdgeInsets.all(SizeConstant.PADDING),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/images/search_empty.png'),
                          width: 250,
                        ),
                        Text(
                          'No Backup Device Selected',
                          style: GoogleFonts.notoSans(
                            fontStyle: FontStyle.italic,
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE_HINT,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(SizeConstant.PADDING),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () async {
            if (!controller.mainDevice.value &&
                !controller.backupDevice.value) {
              return QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error',
                text: 'Please select devices.',
              );
            }

            final isConfirmed = await ShowAlert.showConfirmAlert(
              Get.context!,
              'Confirm',
              'Are you sure you want to submit the request?',
            );

            if (isConfirmed == true) {
              ShowAlert.showLoadingAlert(Get.context!, 'Submitting Request...');

              final result = await controller.submitRequest();

              if (result == true) {
                ShowAlert.showSuccessAlert(
                  Get.context!,
                  'Request Submitted',
                  'Your request has been successfully submitted.',
                );
              }
            }
          },
          child: Text(
            'Request',
            style: GoogleFonts.notoSans(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
