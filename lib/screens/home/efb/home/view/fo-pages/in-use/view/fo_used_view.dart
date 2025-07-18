import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/controller/fo_used_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:airmaster/widgets/build_row.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

class Fo_Used_View extends GetView<Fo_Used_Controller> {
  const Fo_Used_View({super.key});

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
            "EFB | Request Detail Device",
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
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.tertiaryColor,
                borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
                border: Border.all(color: ColorConstants.successColor),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                      value: controller.device['mainDeviceRemark'] ?? '-',
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
                      value: controller.device['backupDeviceiOSVersion'],
                    ),
                    BuildRow(
                      label: "Fly Smart Version",
                      value: controller.device['backupDeviceFlySmart'],
                    ),
                    BuildRow(
                      label: "Docunet Version",
                      value: controller.device['backupDeviceDocuVersion'],
                    ),
                    BuildRow(
                      label: "Lido mPilot Version",
                      value: controller.device['backupDeviceLidoVersion'],
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
                      value: controller.device['backupDeviceRemark'] ?? '-',
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
                          controller.device['status'].toString() == 'waiting'
                              ? 'Waiting'
                              : '',
                    ),
                    BuildRow(
                      label: "Date",
                      value: DateFormatter.convertDateTimeDisplay(
                        controller.device['request_date'],
                        "d MMMM yyyy",
                      ),
                    ),
                    CustomDivider(divider: 'Feedback Form'),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Fill out this form after you complete the flight",
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textPrimary,
                                    fontSize: SizeConstant.TEXT_SIZE_HINT,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "(Optional)",
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textTertiary,
                                    fontSize: SizeConstant.TEXT_SIZE_HINT,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Divider(
                                  color: ColorConstants.dividerColor,
                                  thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                                ),
                              ],
                            ),
                            controller.isFeedback.value
                                ? SizedBox(
                                  child: OutlinedButton.icon(
                                    onPressed: () async {},
                                    label: Text(
                                      'Thanks for your feedback!',
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.textPrimary,
                                        fontSize: SizeConstant.TEXT_SIZE_HINT,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: ColorConstants.blackColor,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          SizeConstant.BORDER_RADIUS,
                                        ),
                                      ),
                                      elevation: SizeConstant.CARD_ELEVATION,
                                    ),
                                  ),
                                )
                                : Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        Get.toNamed(
                                          AppRoutes.EFB_FO_FEEDBACK,
                                          arguments: {
                                            'device': controller.device,
                                          },
                                        );
                                      },
                                      child: Text(
                                        "Feedback",
                                        style: GoogleFonts.notoSans(
                                          color: ColorConstants.textSecondary,
                                          fontSize: SizeConstant.TEXT_SIZE_HINT,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          ],
                        ),
                      ),
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
                    SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Choose who you want to return it to :',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConstant.HORIZONTAL_PADDING,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioListTile<String>(
                            title: Text(
                              'Return to OCC',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            value: 'occHandover',
                            groupValue: controller.handOverTo.value,
                            onChanged: (value) {
                              controller.handOverTo.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Handover to another crew',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            value: 'pilotHandover',
                            groupValue: controller.handOverTo.value,
                            onChanged: (value) {
                              controller.handOverTo.value = value.toString();
                            },
                            activeColor: ColorConstants.activeColor,
                          ),
                        ],
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
              backgroundColor: ColorConstants.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () async {
              if (controller.handOverTo.value.isEmpty) {
                return QuickAlert.show(
                  context: Get.context!,
                  type: QuickAlertType.warning,
                  title: 'Warning',
                  text: 'Please select where to return the device first.',
                );
              } else {
                final confirmed = await ShowAlert.showConfirmAlert(
                  context,
                  'Confirm Return',
                  'Are you sure you want to return the device to ${controller.handOverTo.value == 'occHandover' ? 'OCC' : 'another Crew'}? This action cannot be undone.',
                );

                if (confirmed == true) {
                  ShowAlert.showLoadingAlert(
                    Get.context!,
                    'Returning Device...',
                  );

                  if (controller.handOverTo.value == 'occHandover') {
                    await Future.delayed(const Duration(seconds: 2));
                    Get.back();
                    Get.toNamed(
                      AppRoutes.EFB_OCC_RETURN,
                      arguments: {
                        'device': controller.device,
                        'feedback': controller.feedback,
                      },
                    );
                  } else if (controller.handOverTo.value == 'pilotHandover') {
                    await Future.delayed(const Duration(seconds: 2));
                    Get.back();
                    Get.toNamed(
                      AppRoutes.EFB_HANDOVER,
                      arguments: {
                        'device': controller.device,
                        'feedback': controller.feedback,
                      },
                    );
                  }
                }
              }
            },
            child: Text(
              'Return Device',
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
