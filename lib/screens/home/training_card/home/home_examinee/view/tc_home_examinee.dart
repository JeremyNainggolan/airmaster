// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/home/home_examinee/controller/tc_home_examinee_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_Home_Examinee extends GetView<TC_Home_Examinee_Controller> {
  const TC_Home_Examinee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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

                        const SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
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

                RefreshIndicator(
                  onRefresh: controller.needFeedback,
                  backgroundColor: ColorConstants.backgroundColor,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need Confirmation',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.hintColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),

                        if (controller.feedbackRequired.isEmpty)
                          Center(
                            child: Text(
                              'No confirmation needed at the moment.',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
