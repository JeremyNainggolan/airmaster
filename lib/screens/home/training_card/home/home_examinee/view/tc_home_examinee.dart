// ignore_for_file: camel_case_types

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/home/home_examinee/controller/tc_home_examinee_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_Home_Examinee extends GetView<TC_Home_Examinee_Controller> {
  const TC_Home_Examinee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Obx(
        () =>
            controller.isLoading.value
                ? Center(
                  child: LoadingAnimationWidget.hexagonDots(
                    color: ColorConstants.primaryColor,
                    size: 48,
                  ),
                )
                : RefreshIndicator(
                  onRefresh: () async {
                    await controller.needFeedback();
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(SizeConstant.SCREEN_PADDING),
                    children: [
                      // --- Card Profile ---
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
                              const SizedBox(
                                width: SizeConstant.SIZED_BOX_WIDTH,
                              ),
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
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
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      Divider(
                        color: ColorConstants.dividerColor,
                        thickness: SizeConstant.DIVIDER_THICKNESS,
                      ),
                      const SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),

                      // --- Feedback Required Section ---
                      Text(
                        'Feedback Required',
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.hintColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      controller.feedbackRequired.isEmpty
                          ? Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'No feedback required at the moment.',
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          : ListView.builder(
                            itemCount: controller.feedbackRequired.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final feedback =
                                  controller.feedbackRequired[index];
                              return Card(
                                color: ColorConstants.backgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    SizeConstant.BORDER_RADIUS,
                                  ),
                                ),
                                elevation: SizeConstant.CARD_ELEVATION,
                                shadowColor: ColorConstants.shadowColor,
                                child: ListTile(
                                  title: Text(
                                    feedback['attendance_subject'] ??
                                        'No Training Name',
                                    style: GoogleFonts.notoSans(
                                      color: ColorConstants.textPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    feedback['attendance_date'] != null
                                        ? DateFormat('dd MMMM yyyy').format(
                                          DateTime.parse(
                                            feedback['attendance_date'],
                                          ),
                                        )
                                        : 'No Date',
                                    style: GoogleFonts.notoSans(
                                      color: ColorConstants.textPrimary,
                                      fontSize: 14,
                                    ),
                                  ),
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes.TC_EXAMINEE_FEEDBACK_REQUIRED,
                                      arguments: feedback,
                                    );
                                  },
                                  leading: Icon(
                                    Icons.menu,
                                    color: ColorConstants.hintColor,
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: ColorConstants.hintColor,
                                  ),
                                ),
                              );
                            },
                          ),
                    ],
                  ),
                ),
      ),
    );
  }
}
