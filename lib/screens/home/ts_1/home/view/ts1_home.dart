// ignore_for_file: camel_case_types

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/ts_1/home/controller/ts1_home_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TS1_Home extends GetView<TS1_Home_Controller> {
  const TS1_Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(
            () => Column(
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
                        CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              controller.imgUrl.value.isNotEmpty
                                  ? NetworkImage(controller.imgUrl.value)
                                  : AssetImage(
                                        'assets/images/default_picture.png',
                                      )
                                      as ImageProvider,
                        ),

                        SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, ${controller.name.value}",
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textSecondary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Good ${controller.greetings.value}',
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textSecondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
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
                Divider(
                  color: ColorConstants.dividerColor,
                  thickness: SizeConstant.DIVIDER_THICKNESS,
                ),
                Padding(
                  padding: const EdgeInsets.all(SizeConstant.PADDING),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Assessment',
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          Get.toNamed(AppRoutes.TS1_CANDIDATE_ASSESSMENT);
                        },
                        icon: Icon(
                          Icons.add,
                          color: ColorConstants.primaryColor,
                        ),
                        label: Text(
                          'New Assessment',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: ColorConstants.primaryColor),
                          backgroundColor: ColorConstants.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
