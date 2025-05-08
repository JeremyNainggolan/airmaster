// ignore_for_file: camel_case_types
import 'package:airmaster/screens/home/ts_1/home/controller/ts1_home_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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

                      const SizedBox(width: 12),
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
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorConstants.cardColorSecondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: ColorConstants.backgroundColor,
                            size: 36,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormatter.convertDateTimeDisplay(
                              DateTime.now().toString(),
                              "EEEE",
                            ),
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormatter.convertDateTimeDisplay(
                              DateTime.now().toString(),
                              "dd MMMM yyyy",
                            ),
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: ColorConstants.dividerColor,
                thickness: SizeConstant.DIVIDER_THICKNESS,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
