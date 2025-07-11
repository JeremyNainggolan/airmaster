// ignore_for_file: camel_case_types

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/home/home_instructor/controller/tc_home_instructor_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_Home_Instructor extends GetView<TC_Home_Instructor_Controller> {
  const TC_Home_Instructor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: LoadingAnimationWidget.hexagonDots(color: ColorConstants.primaryColor, size: 48),
          );
        }
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

                Divider(color: ColorConstants.dividerColor),

                RefreshIndicator(
                  onRefresh:
                      () => controller.getTrainingOverview(
                        controller.userId.value,
                      ),
                  backgroundColor: ColorConstants.backgroundColor,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TRAINING OVERVIEW',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        controller.trainingOverviewList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.trainingOverviewList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: ColorConstants.backgroundColor,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 0,
                                      vertical: 8,
                                    ),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: ColorConstants.borderColor,
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.event_note_rounded,
                                      color: ColorConstants.activeColor,
                                      size: 25,
                                    ),
                                    title: Text(
                                      controller
                                          .trainingOverviewList[index]['subject'],
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      controller.trainingOverviewList[index]['date'] !=
                                              null
                                          ? DateFormat('dd MMMM yyyy').format(
                                            (DateTime.parse(
                                              controller
                                                  .trainingOverviewList[index]['date'],
                                            )),
                                          )
                                          : 'Unknown',
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.blackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: ColorConstants.blackColor,
                                      size: 18,
                                    ),

                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes
                                            .TC_INSTRUCTOR_ATTENDANCE_LIST,
                                        arguments: controller.trainingOverviewList[index],
                                      );
                                    },
                                  ),
                                );
                              },
                            )
                            : SizedBox(
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 12),
                                    Text(
                                      "Empty",
                                      style: GoogleFonts.notoSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "You have no list",
                                      style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
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
