import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/waiting-confirmation/controller/fo_waiting_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:airmaster/widgets/build_row.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fo_Waiting_View extends GetView<Fo_Waiting_Controller> {
  const Fo_Waiting_View({super.key});

  @override
  Widget build(BuildContext context) {
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
          "EFB | FO Waiting Confirmation",
          style: GoogleFonts.notoSans(
            color: ColorConstants.textSecondary,
            fontSize: SizeConstant.SUB_HEADING_SIZE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      body: Obx(
        () => SingleChildScrollView(
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
                  ],
                ),
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
            final isConfirmed = await ShowAlert.showConfirmAlert(
              Get.context!,
              'Confirm',
              'Are you sure you want to cancel this request?',
            );

            if (isConfirmed == true) {
              ShowAlert.showLoadingAlert(Get.context!, 'Cancelling Request...');
              final isSuccess = await controller.cancelRequest();
              if (isSuccess) {
                ShowAlert.showSuccessAlert(
                  Get.context!,
                  'Success',
                  'Request has been successfully cancelled.',
                );
              } else {
                ShowAlert.showErrorAlert(
                  Get.context!,
                  'Error',
                  'Failed to cancel the request. Please try again.',
                );
              }
            }
          },
          child: Text(
            'Reject',
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
