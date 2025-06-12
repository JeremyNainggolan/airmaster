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
          "EFB | Used Device",
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
                          controller.device['status'].toString() == 'used'
                              ? 'In Use'
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
    );
  }
}
