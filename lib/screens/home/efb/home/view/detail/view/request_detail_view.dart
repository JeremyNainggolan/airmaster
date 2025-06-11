// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/controller/request_detail_controller.dart';
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

class Detail_View extends GetView<Detail_Controller> {
  const Detail_View({super.key});

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
                  CustomDivider(divider: 'Feedback Form'),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                          Obx(
                            () =>
                                controller.isFeedback.value
                                    ? SizedBox(
                                      child: OutlinedButton.icon(
                                        onPressed: () async {
                                          log(
                                            'Device: ${controller.device.toString()}',
                                          );
                                          log(
                                            'Feedback: ${controller.feedback.toString()}',
                                          );
                                        },
                                        label: Text(
                                          'Thanks for your feedback!',
                                          style: GoogleFonts.notoSans(
                                            color: ColorConstants.textPrimary,
                                            fontSize:
                                                SizeConstant.TEXT_SIZE_HINT,
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
                                          elevation:
                                              SizeConstant.CARD_ELEVATION,
                                        ),
                                      ),
                                    )
                                    : Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            log(
                                              'Device: ${controller.device.toString()}',
                                            );
                                            Get.toNamed(
                                              AppRoutes.EFB_FEEDBACK,
                                              arguments: {
                                                'device': controller.device,
                                              },
                                            );
                                          },
                                          child: Text(
                                            "Feedback",
                                            style: GoogleFonts.notoSans(
                                              color:
                                                  ColorConstants.textSecondary,
                                              fontSize:
                                                  SizeConstant.TEXT_SIZE_HINT,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
                    child: Obx(
                      () => Column(
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
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.handOverTo.value.isEmpty) {
                          await ShowAlert.showErrorAlert(
                            context,
                            'Failed',
                            'Please select who to return the device to.',
                          );
                        } else {
                          final confirmed = await ShowAlert.showConfirmAlert(
                            context,
                            'Confirm Return',
                            'Are you sure you want to return the device to ${controller.handOverTo.value == 'occHandover' ? 'OCC' : 'another Crew'}? This action cannot be undone.',
                          );

                          if (confirmed == true) {
                            QuickAlert.show(
                              barrierDismissible: false,
                              context: Get.context!,
                              type: QuickAlertType.loading,
                              text: 'Loading...',
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
                            } else if (controller.handOverTo.value ==
                                'pilotHandover') {
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
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        backgroundColor: WidgetStateProperty.all(
                          ColorConstants.primaryColor,
                        ),
                      ),
                      child: Text(
                        'Return Device',
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
        ),
      ),
    );
  }
}
