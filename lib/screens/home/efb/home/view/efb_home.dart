// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/efb/home/controller/efb_home_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:airmaster/widgets/build_row.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class EFB_Home extends GetView<EFB_Home_Controller> {
  const EFB_Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
        child: Column(
          children: [
            Card(
              color: ColorConstants.cardColorPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
              ),
              elevation: SizeConstant.CARD_ELEVATION,
              shadowColor: ColorConstants.shadowColor,
              child: Padding(
                padding: const EdgeInsets.all(SizeConstant.PADDING),
                child: Row(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            controller.imgUrl.value.isNotEmpty
                                ? NetworkImage(controller.imgUrl.value)
                                : AssetImage(
                                      'assets/images/default_picture.png',
                                    )
                                    as ImageProvider,
                      ),
                    ),

                    const SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              "Hello, ${controller.name.value}",
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textSecondary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              'Good ${controller.greetings.value}',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textSecondary,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormatter.convertDateTimeDisplay(
                              DateTime.now().toString(),
                              "EEEE",
                            ),
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textSecondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            DateFormatter.convertDateTimeDisplay(
                              DateTime.now().toString(),
                              "MMM d, yyyy",
                            ),
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),

            Obx(() {
              if (controller.rank.value.toString() == 'OCC') {
                return Expanded(
                  child: Column(
                    children: [
                      Divider(
                        color: ColorConstants.dividerColor,
                        thickness: SizeConstant.DIVIDER_THICKNESS,
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.whiteColor,
                          borderRadius: BorderRadius.circular(
                            SizeConstant.BORDER_RADIUS,
                          ),
                          border: Border.all(
                            color: ColorConstants.primaryColor,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(SizeConstant.PADDING),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.airplanemode_on,
                                        color: ColorConstants.primaryColor,
                                        size: 35,
                                      ),
                                      SizedBox(
                                        width: SizeConstant.SIZED_BOX_WIDTH,
                                      ),
                                      Text(
                                        controller.hub.value,
                                        style: GoogleFonts.notoSans(
                                          color: ColorConstants.textPrimary,
                                          fontSize: SizeConstant.TEXT_SIZE_MAX,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 2,
                                height: 30,
                                color: ColorConstants.primaryColor,
                                margin: EdgeInsets.symmetric(
                                  horizontal: SizeConstant.PADDING,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConstant.HORIZONTAL_PADDING,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Available Devices: ${controller.availableDevicesCount.value}',
                                                style: GoogleFonts.notoSans(
                                                  color:
                                                      ColorConstants
                                                          .textPrimary,
                                                  fontSize:
                                                      SizeConstant.TEXT_SIZE,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Device Used: ${controller.usedDevicesCount.value}',
                                                style: GoogleFonts.notoSans(
                                                  color:
                                                      ColorConstants
                                                          .textPrimary,
                                                  fontSize:
                                                      SizeConstant.TEXT_SIZE,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      TabBar(
                        controller: controller.occTabController,
                        tabs: [
                          Tab(text: 'Request'),
                          Tab(text: 'In Use'),
                          Tab(text: 'Return'),
                        ],
                        dividerColor: Colors.transparent,
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      Expanded(
                        child: TabBarView(
                          controller: controller.occTabController,
                          children: [
                            Obx(() {
                              return RefreshIndicator(
                                onRefresh: controller.refreshDataOCC,
                                child:
                                    controller.requestConfirmationOCC.isEmpty
                                        ? ListView(
                                          children: [
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.device_hub,
                                                    size: 40,
                                                    color:
                                                        ColorConstants
                                                            .primaryColor,
                                                  ),
                                                  Text(
                                                    'No Request Coming',
                                                    style: GoogleFonts.notoSans(
                                                      color:
                                                          ColorConstants
                                                              .textPrimary,
                                                      fontSize:
                                                          SizeConstant
                                                              .TEXT_SIZE_HINT,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                        : ListView.builder(
                                          itemCount:
                                              controller
                                                  .requestConfirmationOCC
                                                  .length,
                                          itemBuilder: (context, index) {
                                            final device =
                                                controller
                                                    .requestConfirmationOCC[index];
                                            return Card(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color:
                                                      ColorConstants.blackColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      SizeConstant
                                                          .BORDER_RADIUS,
                                                    ),
                                              ),
                                              color:
                                                  ColorConstants
                                                      .backgroundColor,
                                              child: ListTile(
                                                onTap: () async {
                                                  final result =
                                                      await Get.toNamed(
                                                        AppRoutes
                                                            .EFB_REQUESTED_TO_OCC,
                                                        arguments: {
                                                          'device': device,
                                                        },
                                                      );

                                                  if (result == true) {
                                                    controller.refreshDataOCC();
                                                  }
                                                },
                                                leading: Icon(Icons.device_hub),
                                                trailing: Icon(
                                                  Icons.chevron_right,
                                                  color: Colors.black,
                                                ),
                                                title: Text(
                                                  device['deviceno'],
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant.TEXT_SIZE,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  'Request Date: ${DateFormatter.convertDateTimeDisplay(device['request_date'], "MMM d, yyyy")}',
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant
                                                            .TEXT_SIZE_HINT,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              );
                            }),

                            Obx(() {
                              return RefreshIndicator(
                                onRefresh: controller.refreshDataOCC,
                                child:
                                    controller.deviceUsedOCC.isEmpty
                                        ? ListView(
                                          children: [
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.device_hub,
                                                    size: 40,
                                                    color:
                                                        ColorConstants
                                                            .primaryColor,
                                                  ),
                                                  Text(
                                                    'No Devices in Use',
                                                    style: GoogleFonts.notoSans(
                                                      color:
                                                          ColorConstants
                                                              .textPrimary,
                                                      fontSize:
                                                          SizeConstant
                                                              .TEXT_SIZE_HINT,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                        : ListView.builder(
                                          itemCount:
                                              controller.deviceUsedOCC.length,
                                          itemBuilder: (context, index) {
                                            final device =
                                                controller.deviceUsedOCC[index];
                                            return Card(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color:
                                                      ColorConstants.blackColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      SizeConstant
                                                          .BORDER_RADIUS,
                                                    ),
                                              ),
                                              color:
                                                  ColorConstants
                                                      .backgroundColor,
                                              child: ListTile(
                                                onTap: () async {
                                                  final result =
                                                      await Get.toNamed(
                                                        AppRoutes
                                                            .EFB_USED_TO_OCC,
                                                        arguments: {
                                                          'device': device,
                                                        },
                                                      );

                                                  if (result == true) {
                                                    controller.refreshDataOCC();
                                                  }
                                                },
                                                leading: Icon(Icons.device_hub),
                                                trailing: Icon(
                                                  Icons.chevron_right,
                                                  color: Colors.black,
                                                ),
                                                title: Text(
                                                  device['deviceno'],
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant.TEXT_SIZE,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  'Request Date: ${DateFormatter.convertDateTimeDisplay(device['request_date'], "MMM d, yyyy")}',
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant
                                                            .TEXT_SIZE_HINT,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              );
                            }),

                            Obx(() {
                              return RefreshIndicator(
                                onRefresh: controller.refreshDataOCC,
                                child:
                                    controller.returnConfirmationOCC.isEmpty
                                        ? ListView(
                                          children: [
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.device_hub,
                                                    size: 40,
                                                    color:
                                                        ColorConstants
                                                            .primaryColor,
                                                  ),
                                                  Text(
                                                    'No Return Request Coming',
                                                    style: GoogleFonts.notoSans(
                                                      color:
                                                          ColorConstants
                                                              .textPrimary,
                                                      fontSize:
                                                          SizeConstant
                                                              .TEXT_SIZE_HINT,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                        : ListView.builder(
                                          itemCount:
                                              controller
                                                  .returnConfirmationOCC
                                                  .length,
                                          itemBuilder: (context, index) {
                                            final device =
                                                controller
                                                    .returnConfirmationOCC[index];
                                            return Card(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color:
                                                      ColorConstants.blackColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      SizeConstant
                                                          .BORDER_RADIUS,
                                                    ),
                                              ),
                                              color:
                                                  ColorConstants
                                                      .backgroundColor,
                                              child: ListTile(
                                                onTap: () async {
                                                  final result =
                                                      await Get.toNamed(
                                                        AppRoutes
                                                            .EFB_RETURNED_TO_OCC,
                                                        arguments: {
                                                          'device': device,
                                                        },
                                                      );

                                                  if (result == true) {
                                                    controller.refreshDataOCC();
                                                  }
                                                },
                                                leading: Icon(Icons.device_hub),
                                                trailing: Icon(
                                                  Icons.chevron_right,
                                                  color: Colors.black,
                                                ),
                                                title: Text(
                                                  device['deviceno'],
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant.TEXT_SIZE,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  'Request Date: ${DateFormatter.convertDateTimeDisplay(device['request_date'], "MMM d, yyyy")}',
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant
                                                            .TEXT_SIZE_HINT,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Expanded(
                  child: Column(
                    children: [
                      Divider(
                        color: ColorConstants.dividerColor,
                        thickness: SizeConstant.DIVIDER_THICKNESS,
                      ),
                      Obx(
                        () =>
                            controller.checkRequest.value
                                ? SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: () async {
                                      final result = await Get.toNamed(
                                        AppRoutes.EFB_REQUEST,
                                      );

                                      if (result == true) {
                                        controller.refreshData();
                                      }
                                    },
                                    icon: Icon(
                                      size: 25.0,
                                      Icons.device_hub,
                                      color: ColorConstants.blackColor,
                                    ),
                                    label: Text(
                                      'Request Device',
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.textPrimary,
                                        fontSize: SizeConstant.TEXT_SIZE,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: ColorConstants.blackColor,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: SizeConstant.CARD_ELEVATION,
                                    ),
                                  ),
                                )
                                : SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    label: Text(
                                      'To request a device, please wait for confirmation.',
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.textPrimary,
                                        fontSize: SizeConstant.TEXT_SIZE_HINT,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: ColorConstants.blackColor,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: SizeConstant.CARD_ELEVATION,
                                    ),
                                  ),
                                ),
                      ),
                      TabBar(
                        controller: controller.pilotTabController,
                        tabs: [
                          Tab(text: 'Waiting Confirmation'),
                          Tab(text: 'In Use'),
                        ],
                        dividerColor: Colors.transparent,
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      Expanded(
                        child: TabBarView(
                          controller: controller.pilotTabController,
                          children: [
                            Obx(() {
                              return RefreshIndicator(
                                onRefresh: controller.refreshData,
                                child:
                                    controller.waitingConfirmation.isEmpty
                                        ? ListView(
                                          children: [
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.device_hub,
                                                    size: 40,
                                                    color:
                                                        ColorConstants
                                                            .primaryColor,
                                                  ),
                                                  Text(
                                                    'No devices waiting for confirmation',
                                                    style: GoogleFonts.notoSans(
                                                      color:
                                                          ColorConstants
                                                              .textPrimary,
                                                      fontSize:
                                                          SizeConstant
                                                              .TEXT_SIZE_HINT,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                        : ListView.builder(
                                          itemCount:
                                              controller
                                                  .waitingConfirmation
                                                  .length,
                                          itemBuilder: (context, index) {
                                            final device =
                                                controller
                                                    .waitingConfirmation[index];
                                            return Card(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color:
                                                      ColorConstants.blackColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      SizeConstant
                                                          .BORDER_RADIUS,
                                                    ),
                                              ),
                                              color:
                                                  ColorConstants
                                                      .backgroundColor,
                                              child: ListTile(
                                                onTap: () async {
                                                  showWaitingDeviceDialog(
                                                    device['deviceno'],
                                                  );
                                                },
                                                leading: Icon(Icons.device_hub),
                                                trailing: Icon(
                                                  Icons.chevron_right,
                                                  color: Colors.black,
                                                ),
                                                title: Text(
                                                  device['deviceno'],
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant.TEXT_SIZE,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  'Request Date: ${DateFormatter.convertDateTimeDisplay(device['request_date'], "MMM d, yyyy")}',
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant
                                                            .TEXT_SIZE_HINT,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              );
                            }),

                            Obx(() {
                              return RefreshIndicator(
                                onRefresh: controller.refreshData,
                                child:
                                    controller.inUse.isEmpty
                                        ? ListView(
                                          children: [
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.device_hub,
                                                    size: 40,
                                                    color:
                                                        ColorConstants
                                                            .primaryColor,
                                                  ),
                                                  Text(
                                                    'No devices in use',
                                                    style: GoogleFonts.notoSans(
                                                      color:
                                                          ColorConstants
                                                              .textPrimary,
                                                      fontSize:
                                                          SizeConstant
                                                              .TEXT_SIZE_HINT,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                        : ListView.builder(
                                          itemCount: controller.inUse.length,
                                          itemBuilder: (context, index) {
                                            final device =
                                                controller.inUse[index];
                                            return Card(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color:
                                                      ColorConstants.blackColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      SizeConstant
                                                          .BORDER_RADIUS,
                                                    ),
                                              ),
                                              color:
                                                  ColorConstants
                                                      .backgroundColor,
                                              child: ListTile(
                                                onTap: () async {
                                                  log(
                                                    'Tapped on device: ${device.toString()}',
                                                  );

                                                  final result =
                                                      await Get.toNamed(
                                                        AppRoutes.EFB_DETAIL,
                                                        arguments: {
                                                          'device': device,
                                                        },
                                                      );

                                                  if (result == true) {
                                                    log('RESULT TRUE');
                                                    controller.refreshData();
                                                  }
                                                  // showUsedDeviceDialog(
                                                  //   device['deviceno'],
                                                  // );
                                                },
                                                leading: Icon(Icons.device_hub),
                                                trailing: Icon(
                                                  Icons.chevron_right,
                                                  color: Colors.black,
                                                ),
                                                title: Text(
                                                  device['deviceno'],
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant.TEXT_SIZE,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  'Request Date: ${DateFormatter.convertDateTimeDisplay(device['request_date'], "MMM d, yyyy")}',
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant
                                                            .TEXT_SIZE_HINT,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Future<void> showWaitingDeviceDialog(String deviceNo) async {
    Map device = await controller.getPilotDevices(deviceNo);
    log('Device details: $device');
    return showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: ColorConstants.backgroundColor,
          shadowColor: ColorConstants.shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
          ),
          child: Padding(
            padding: EdgeInsets.all(SizeConstant.PADDING),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Request Device Details',
                  style: GoogleFonts.notoSans(
                    color: ColorConstants.textPrimary,
                    fontSize: SizeConstant.TEXT_SIZE_MAX,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_DOUBLE),
                BuildRow(label: 'Device Number', value: device['deviceno']),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                BuildRow(label: 'iOS Version', value: device['ios_version']),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                BuildRow(
                  label: 'Fly Smart Version',
                  value: device['fly_smart'],
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                BuildRow(
                  label: 'Lido mPilot Version',
                  value: device['lido_version'],
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                BuildRow(label: 'Doc Version', value: device['doc_version']),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                BuildRow(label: 'Hub', value: device['hub']),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                BuildRow(label: 'Category', value: device['category']),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                CustomDivider(divider: 'Requested By'),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                BuildRow(label: 'ID', value: device['request_user']),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                BuildRow(label: 'Name', value: device['request_user_name']),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                BuildRow(
                  label: 'Date',
                  value: DateFormatter.convertDateTimeDisplay(
                    device['request_date'],
                    "d MMMM yyyy",
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                BuildRow(
                  label: 'Status',
                  value:
                      device['status'].toString() == 'waiting' ? 'Waiting' : '',
                ),

                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_DOUBLE),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(Get.context!).pop();

                      QuickAlert.show(
                        barrierDismissible: false,
                        context: Get.context!,
                        type: QuickAlertType.loading,
                        text: 'Submitting...',
                      );

                      var result = await controller.cancelRequest(
                        device['id']['\$oid'],
                        device['deviceno'],
                      );

                      if (Get.isDialogOpen ?? false) {
                        Get.back();
                      }

                      if (result) {
                        QuickAlert.show(
                          barrierDismissible: false,
                          context: Get.context!,
                          type: QuickAlertType.success,
                          title: 'Success!',
                          text: 'Your request has been successfully cancelled.',
                          confirmBtnTextStyle: GoogleFonts.notoSans(
                            color: ColorConstants.textSecondary,
                            fontSize: SizeConstant.TEXT_SIZE_HINT,
                            fontWeight: FontWeight.normal,
                          ),
                          onConfirmBtnTap: () async {
                            controller.refreshData();
                            Get.back();
                            Get.back();
                          },
                        );
                      } else {
                        QuickAlert.show(
                          context: Get.context!,
                          type: QuickAlertType.error,
                          title: 'Failed',
                          text:
                              'Failed to cancel your request. Please try again.',
                          confirmBtnTextStyle: GoogleFonts.notoSans(
                            color: ColorConstants.textSecondary,
                            fontSize: SizeConstant.TEXT_SIZE_HINT,
                            fontWeight: FontWeight.normal,
                          ),
                          onConfirmBtnTap: () async {
                            Get.back();
                            Get.back();
                          },
                        );
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
                      'Cancel Request',
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
        );
      },
    );
  }
}
