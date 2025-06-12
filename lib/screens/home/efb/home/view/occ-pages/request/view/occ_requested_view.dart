import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/screens/home/efb/home/view/occ-pages/request/controller/occ_requested_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:airmaster/widgets/build_row.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OCC_Requested_View extends GetView<OCC_Requested_Controller> {
  const OCC_Requested_View({super.key});

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
          "EFB | Confirm Device Request",
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
                    "Device Information",
                    style: GoogleFonts.notoSans(
                      color: ColorConstants.textPrimary,
                      fontSize: SizeConstant.SUB_HEADING_SIZE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                  Obx(
                    () => BuildRow(
                      label: "Device No",
                      value: controller.device['deviceno'],
                    ),
                  ),
                  Obx(
                    () => BuildRow(
                      label: "iOS Version",
                      value: controller.device['ios_version'],
                    ),
                  ),
                  Obx(
                    () => BuildRow(
                      label: "Fly Smart Version",
                      value: controller.device['fly_smart'],
                    ),
                  ),
                  Obx(
                    () => BuildRow(
                      label: "Lido mPilot Version",
                      value: controller.device['lido_version'],
                    ),
                  ),
                  Obx(
                    () =>
                        BuildRow(label: "Hub", value: controller.device['hub']),
                  ),
                  Obx(
                    () => BuildRow(
                      label: "Category",
                      value: controller.device['category'],
                    ),
                  ),
                  Obx(
                    () => BuildRow(
                      label: "Remark",
                      value: controller.device['remark'] ?? '-',
                    ),
                  ),
                  CustomDivider(divider: 'Request by'),
                  Obx(
                    () => BuildRow(
                      label: "ID",
                      value: controller.device['request_user'],
                    ),
                  ),
                  Obx(
                    () => BuildRow(
                      label: "Name",
                      value: controller.device['request_user_name'],
                    ),
                  ),
                  Obx(
                    () => BuildRow(
                      label: "Status",
                      value:
                          controller.device['status'].toString() == 'waiting'
                              ? 'Waiting'
                              : '',
                    ),
                  ),
                  Obx(
                    () => BuildRow(
                      label: "Date",
                      value: DateFormatter.convertDateTimeDisplay(
                        controller.device['request_date'],
                        "d MMMM yyyy",
                      ),
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
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.errorColor,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  final confirmed = await ShowAlert.showInfoAlert(
                    Get.context!,
                    'Reject',
                    'Are you sure to reject this requested Device?',
                  );

                  if (confirmed == true) {
                    ShowAlert.showLoadingAlert(Get.context!, 'Please wait...');

                    final success = await controller.reject();

                    if (Get.isDialogOpen ?? false) Get.back();

                    if (success) {
                      await ShowAlert.showSuccessAlert(
                        Get.context!,
                        'Success',
                        'Request succesfully rejected.',
                      );
                    } else {
                      await ShowAlert.showErrorAlert(
                        Get.context!,
                        'Error',
                        'Failed to reject the request.',
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
            SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.successColor,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  final isConfirmed = await ShowAlert.showInfoAlert(
                    Get.context!,
                    'Approve',
                    'Are you sure you want to approve the usage of this device?',
                  );

                  if (isConfirmed == true) {
                    ShowAlert.showLoadingAlert(Get.context!, 'Please wait...');

                    final success = await controller.approve();

                    if (Get.isDialogOpen ?? false) Get.back();

                    if (success) {
                      await ShowAlert.showSuccessAlert(
                        Get.context!,
                        'Success',
                        'Request succesfully approved.',
                      );
                    } else {
                      await ShowAlert.showErrorAlert(
                        Get.context!,
                        'Error',
                        'Failed to approve the request.',
                      );
                    }
                  }
                },
                child: Text(
                  'Approve',
                  style: GoogleFonts.notoSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
