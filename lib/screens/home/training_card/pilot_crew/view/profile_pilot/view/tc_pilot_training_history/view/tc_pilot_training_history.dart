import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/view/tc_pilot_training_history/controller/tc_pilot_training_history_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_PilotTrainingHistory
    extends GetView<TC_PilotTrainingHistory_Controller> {
  const TC_PilotTrainingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Training History',
          style: GoogleFonts.notoSans(
            color: ColorConstants.textSecondary,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.activeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () =>
            controller.isLoading.value
                ? Center(
                  child: LoadingAnimationWidget.hexagonDots(
                    color: ColorConstants.activeColor,
                    size: 48,
                  ),
                )
                : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.subject.value,
                              style: GoogleFonts.notoSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.textPrimary,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              width: 100,
                              child:
                                  controller.status.value == 'VALID'
                                      ? Container(
                                        decoration: BoxDecoration(
                                          color: ColorConstants.successColor,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller.status.value,
                                            style: GoogleFonts.notoSans(
                                              fontSize: 12,
                                              color: ColorConstants.whiteColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                      : controller.status.value == 'EXPIRED'
                                      ? Container(
                                        decoration: BoxDecoration(
                                          color: ColorConstants.errorColor,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller.status.value,
                                            style: GoogleFonts.notoSans(
                                              fontSize: 12,
                                              color: ColorConstants.whiteColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                      : SizedBox(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.trainingHistory.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: ColorConstants.backgroundColor,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                onTap: () {
                                  controller.pilotType.value == 'Examinee'
                                      ? Get.toNamed(
                                        AppRoutes.TC_EXAMINEE_FEEDBACK_REQUIRED,
                                        arguments:
                                            controller.trainingHistory[index],
                                      )
                                      : Get.toNamed(
                                        AppRoutes.TC_DETAIL_PILOT_HISTORY,
                                        arguments:
                                            controller.trainingHistory[index],
                                      );
                                },
                                leading: CircleAvatar(
                                  backgroundColor:
                                      ColorConstants.backgroundNumberColor,
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.whiteColor,
                                    ),
                                  ),
                                ),
                                title: Column(
                                  children: [
                                    Table(
                                      columnWidths: const {
                                        0: FixedColumnWidth(75),
                                        1: FixedColumnWidth(20),
                                        2: FlexColumnWidth(),
                                      },
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 3.0,
                                                  ),
                                              child: Text(
                                                "Date",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 3.0,
                                              ),
                                              child: Text(
                                                ":",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 3.0,
                                                  ),
                                              child: Text(
                                                controller.trainingHistory[index]['history_date'] !=
                                                        null
                                                    ? DateFormat(
                                                      'dd MMMM yyyy',
                                                    ).format(
                                                      DateTime.parse(
                                                        controller
                                                            .trainingHistory[index]['history_date'],
                                                      ),
                                                    )
                                                    : 'NONE',
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        TableRow(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 3.0,
                                                  ),
                                              child: Text(
                                                "Valid To",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 3.0,
                                              ),
                                              child: Text(
                                                ":",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 3.0,
                                                  ),
                                              child: Text(
                                                controller.trainingHistory[index]['history_date'] !=
                                                        null
                                                    ? DateFormat(
                                                      'dd MMMM yyyy',
                                                    ).format(
                                                      DateTime.parse(
                                                        controller
                                                            .trainingHistory[index]['history_valid_to'],
                                                      ),
                                                    )
                                                    : 'NONE',
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: ColorConstants.hintColor,
                                  size: 18,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
