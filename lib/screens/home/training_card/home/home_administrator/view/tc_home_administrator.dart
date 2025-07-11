// ignore_for_file: camel_case_types

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/home/home_administrator/controller/tc_home_administrator_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_Home_Administrator extends GetView<TC_Home_Administrator_Controller> {
  const TC_Home_Administrator({super.key});

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
                Divider(color: ColorConstants.dividerColor, thickness: 2),

                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),

                RefreshIndicator(
                  onRefresh: controller.getStatusConfirmation,
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

                        Obx(() {
                          if (controller.attendanceConfirmed.isEmpty) {
                            return SizedBox(
                              height:
                                  MediaQuery.of(context).size.height *
                                  0.25, // Sekitar setengah layar, bisa kamu atur
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 12),
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
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.attendanceConfirmed.length,
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
                                    contentPadding: EdgeInsets.only(
                                      top: 0,
                                      bottom: 0,
                                      left: 10,
                                      right: 10,
                                    ),
                                    leading: Icon(
                                      Icons.info_outline,
                                      color: Colors.yellow[700],
                                      size: 35,
                                    ),
                                    title: Text(
                                      controller
                                          .attendanceConfirmed[index]['subject'],
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      controller
                                              .attendanceConfirmed[index]['user_name'] ??
                                          'Unknown',
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.activeColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: ColorConstants.labelColor,
                                      size: 18,
                                    ),

                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes
                                            .TC_ATTENDANCE_DETAIL_NEEDCONFIRM,
                                        arguments:
                                            controller
                                                .attendanceConfirmed[index],
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          }
                        }),

                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),

                        Text(
                          'Waiting',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.hintColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        Obx(() {
                          if (controller.attendanceWaiting.isEmpty) {
                            return SizedBox(
                              height:
                                  MediaQuery.of(context).size.height *
                                  0.35, // Sekitar setengah layar, bisa kamu atur
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 12),
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
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.attendanceWaiting.length,
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
                                    contentPadding: EdgeInsets.only(
                                      top: 0,
                                      bottom: 0,
                                      left: 10,
                                      right: 10,
                                    ),
                                    leading: Icon(
                                      Icons.access_time,
                                      color: ColorConstants.activeColor,
                                      size: 35,
                                    ),
                                    title: Text(
                                      controller
                                          .attendanceWaiting[index]['subject'],
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      controller
                                              .attendanceWaiting[index]['user_name'] ??
                                          'Unknown',
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.activeColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: ColorConstants.labelColor,
                                      size: 18,
                                    ),
                                    onTap:
                                        () => Get.toNamed(
                                          AppRoutes
                                              .TC_ATTENDANCE_DETAIL_WAITING,
                                          arguments:
                                              controller
                                                  .attendanceWaiting[index],
                                        ),
                                  ),
                                );
                              },
                            );
                          }
                        }),
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
