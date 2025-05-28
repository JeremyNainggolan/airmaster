// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/controller/efb_home_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EFB_Home extends GetView<EFB_Home_Controller> {
  const EFB_Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Card(
                color: ColorConstants.cardColorPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    SizeConstant.BORDER_RADIUS,
                  ),
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormatter.convertDateTimeDisplay(
                                DateTime.now().toString(),
                                "dd MMMM yyyy",
                              ),
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
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
                              SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
                              Obx(
                                () => Text(
                                  controller.hub.value,
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textPrimary,
                                    fontSize: SizeConstant.TEXT_SIZE_MAX,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                horizontal: SizeConstant.HORIZONTAL_PADDING,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Obx(
                                        () => Text(
                                          'Available Devices: ${controller.availableDevicesCount.value}',
                                          style: GoogleFonts.notoSans(
                                            color: ColorConstants.textPrimary,
                                            fontSize: SizeConstant.TEXT_SIZE,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Obx(
                                        () => Text(
                                          'Device Used: ${controller.usedDevicesCount.value}',
                                          style: GoogleFonts.notoSans(
                                            color: ColorConstants.textPrimary,
                                            fontSize: SizeConstant.TEXT_SIZE,
                                            fontWeight: FontWeight.w600,
                                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
