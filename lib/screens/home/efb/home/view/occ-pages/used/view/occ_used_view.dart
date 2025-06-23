import 'package:airmaster/screens/home/efb/home/view/occ-pages/used/controller/occ_used_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:airmaster/widgets/build_row.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OCC_Used_View extends GetView<OCC_Used_Controller> {
  const OCC_Used_View({super.key});

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
            "EFB | Confirm Device Request",
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: SizeConstant.SUB_HEADING_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: ColorConstants.backgroundColor,
        body:
            controller.device['isFoRequest']
                ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
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
                            CustomDivider(divider: 'Request User Information'),
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
                                          'used'
                                      ? 'In Use'
                                      : '',
                            ),
                            BuildRow(
                              label: "Date",
                              value: DateFormatter.convertDateTimeDisplay(
                                controller.device['request_date'],
                                "d MMMM yyyy",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
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
                                          'used'
                                      ? 'In Use'
                                      : '',
                            ),
                            BuildRow(
                              label: "Date",
                              value: DateFormatter.convertDateTimeDisplay(
                                controller.device['request_date'],
                                "d MMMM yyyy",
                              ),
                            ),
                          ],
                        ),
                      ),
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
              Get.back();
            },
            child: Text(
              'Back',
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
