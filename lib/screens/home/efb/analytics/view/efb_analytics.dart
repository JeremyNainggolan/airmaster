// ignore_for_file: camel_case_types
import 'package:airmaster/screens/home/efb/analytics/controller/efb_analytics_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:airmaster/widgets/legend_widget.dart';
import 'package:airmaster/widgets/pie_chart.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EFB_Analytics extends GetView<EFB_Analytics_Controller> {
  const EFB_Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: LoadingAnimationWidget.hexagonDots(
              color: ColorConstants.primaryColor,
              size: 48,
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
              child: Column(
                children: [
                  Text(
                    'Analytics Report',
                    style: GoogleFonts.notoSans(
                      fontSize: SizeConstant.HEADING_SIZE,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.textTertiary,
                    ),
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConstant.PADDING,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onTap: () async {
                              await controller.selectFromDate();
                            },
                            readOnly: true,
                            autofocus: false,
                            controller: controller.fromDate,
                            decoration: _customDecoration('From Date'),
                          ),
                        ),
                        SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
                        Expanded(
                          child: TextField(
                            onTap: () async {
                              await controller.selectToDate();
                            },
                            readOnly: true,
                            autofocus: false,
                            controller: controller.toDate,
                            decoration: _customDecoration('To Date'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value:
                        controller.selectedHub.value.isEmpty
                            ? null
                            : controller.selectedHub.value,
                    decoration: _customDecoration('Select Hub'),
                    dropdownColor: ColorConstants.backgroundColor,
                    items:
                        controller.hubList
                            .map(
                              (hub) => DropdownMenuItem<String>(
                                value: hub,
                                child: Text(
                                  hub,
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textPrimary,
                                    fontSize: SizeConstant.TEXT_SIZE_HINT,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      controller.selectedHub.value = value!;
                      controller.filterData();
                    },
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                  Text(
                    'Currently showing analytics from ${controller.fromDateText} to ${controller.toDateText} for ${controller.selectedHub.value.isEmpty ? 'all hubs' : controller.selectedHub.value}',
                    style: GoogleFonts.notoSans(
                      fontStyle: FontStyle.italic,
                      color: ColorConstants.textPrimary,
                      fontSize: SizeConstant.TEXT_SIZE_HINT,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                  Divider(
                    indent: 40,
                    endIndent: 40,
                    color: ColorConstants.dividerColor,
                    thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Acknowledgment',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textTertiary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                            TextField(
                              controller: controller.acknowledgeCountText,
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: _customDecoration(''),
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Return',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textTertiary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                            TextField(
                              controller: controller.returnCountText,
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: _customDecoration(''),
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'First Device',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textTertiary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                            TextField(
                              controller: controller.firstDeviceAcknowledgeText,
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: _customDecoration(''),
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'First Device',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textTertiary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                            TextField(
                              controller: controller.firstDeviceReturnText,
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: _customDecoration(''),
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Second & Third Device',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textTertiary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                            TextField(
                              controller: controller.otherDeviceAcknowledgeText,
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: _customDecoration(''),
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Second & Third Device',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textTertiary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                            TextField(
                              controller: controller.otherDeviceReturnText,
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: _customDecoration(''),
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),
                  Text(
                    'Unfinished Process',
                    style: GoogleFonts.notoSans(
                      color: ColorConstants.textPrimary,
                      fontSize: SizeConstant.TEXT_SIZE_HINT,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                  Row(
                    children: [
                      Expanded(child: SizedBox()),
                      Expanded(
                        child: TextField(
                          controller: controller.unfinishedProcessCountText,
                          readOnly: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: ColorConstants.primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: ColorConstants.primaryColor,
                              ),
                            ),
                            fillColor: ColorConstants.primaryColor,
                            filled: true,
                          ),
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textSecondary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                  CustomDivider(divider: 'Available Devices'),
                  LegendWidget(items: controller.legendList),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_DOUBLE),
                  LegendPieChart(data: controller.legendListCount),
                  SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_DOUBLE),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  InputDecoration _customDecoration(String? labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: GoogleFonts.notoSans(
        color: ColorConstants.textPrimary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.blackColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.blackColor),
      ),
    );
  }
}
