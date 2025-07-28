import 'dart:developer';

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/profile_examinee/controller/tc_profile_examinee_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_ProfileExaminee extends GetView<TC_ProfileExaminee_Controller> {
  const TC_ProfileExaminee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 10.0,
                        ),
                        child: Card(
                          color: ColorConstants.backgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 14.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 60.0,
                                      bottom: 20.0,
                                    ),
                                    child: Container(
                                      height: 150.0,
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 10,
                                            spreadRadius: 4,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        child:
                                            controller.trainee['photo_url'] !=
                                                    null
                                                ? Image.network(
                                                  controller
                                                      .trainee['photo_url'],
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => Icon(
                                                        Icons.broken_image,
                                                      ),
                                                  fit: BoxFit.cover,
                                                )
                                                : CircleAvatar(
                                                  backgroundColor:
                                                      Colors.blueGrey,
                                                  child: Text(
                                                    (controller.trainee['name'] ??
                                                            '?')
                                                        .toString()
                                                        .substring(0, 1)
                                                        .toUpperCase(),
                                                    style: GoogleFonts.notoSans(
                                                      fontSize: 72,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: SizeConstant.SPACING),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.trainee['name'],
                                      style: GoogleFonts.notoSans(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: ColorConstants.textPrimary,
                                      ),
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller.trainee['rank'],
                                          style: GoogleFonts.notoSans(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: ColorConstants.hintColor,
                                          ),
                                        ),

                                        Text(
                                          ' | ${controller.trainee['id_number']}',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: ColorConstants.hintColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Table(
                                      columnWidths: const {
                                        0: FixedColumnWidth(100),
                                        1: FixedColumnWidth(20),
                                        2: FlexColumnWidth(),
                                      },
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                              ),
                                              child: Text(
                                                "STATUS",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ":",
                                              style: GoogleFonts.notoSans(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Card(
                                              color:
                                                  controller.trainee['status'] ==
                                                          'VALID'
                                                      ? ColorConstants
                                                          .successColor
                                                      : ColorConstants
                                                          .errorColor,
                                              margin: const EdgeInsets.only(
                                                right: 20.0,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    controller
                                                            .trainee['status'] ??
                                                        'NOT VALID',
                                                    style: GoogleFonts.notoSans(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                "RANK",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                ":",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                controller.trainee['rank'] ??
                                                    'UNKNOWN',
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        TableRow(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                "Email",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                ":",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                controller.trainee['email'] ??
                                                    'UNKNOWN',
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        TableRow(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                "HUB",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                ":",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                controller.trainee['hub'] ??
                                                    'UNKNOWN',
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        TableRow(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                "LICENSE NO",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                ":",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                controller
                                                        .trainee['license_number'] ??
                                                    'UNKNOWN',
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        TableRow(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                "ID NO",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                ":",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                              ),
                                              child: Text(
                                                controller
                                                        .trainee['id_number'] ??
                                                    'UNKNOWN',
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TRAINING",
                              style: GoogleFonts.notoSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.textPrimary,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  try {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return LoadingAnimationWidget.hexagonDots(
                                          color: ColorConstants.activeColor,
                                          size: 48,
                                        );
                                      },
                                    );
                                    log('${controller.trainee['id_number']}');
                                    String exportedPDFPath = await controller
                                        .eksportPDF(
                                          controller.trainee['id_number'],
                                        );
                                    if (exportedPDFPath.isNotEmpty) {
                                      await controller.openExportedPDF(
                                        exportedPDFPath,
                                      );
                                    }
                                  } catch (e) {
                                    log('Error: $e');
                                  } finally {
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                label: Text(
                                  "Save PDF",
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.textSecondary,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.pdfColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.trainingList.length,
                        itemBuilder: (context, index) {
                          final trainingName =
                              controller.trainingList[index]['training'];

                          final isValid = controller.historyTraining.any(
                            (history) =>
                                history['history_subject'] == trainingName,
                          );

                          final now = DateTime.now();

                          final matchedHistory =
                              controller.historyTraining
                                  .where(
                                    (history) =>
                                        history['history_subject'] ==
                                            trainingName &&
                                        history['history_valid_to'] != null &&
                                        DateTime.tryParse(
                                              history['history_valid_to'],
                                            )?.isAfter(now) ==
                                            true,
                                  )
                                  .toList()
                                ..sort(
                                  (a, b) => DateTime.parse(
                                    b['history_valid_to'],
                                  ).compareTo(
                                    DateTime.parse(a['history_valid_to']),
                                  ),
                                );

                          final latestValidHistory =
                              matchedHistory.isNotEmpty
                                  ? matchedHistory.first
                                  : null;

                          final historyDate =
                              latestValidHistory != null &&
                                      latestValidHistory['history_valid_to'] !=
                                          null
                                  ? DateFormat('dd MMMM yyyy').format(
                                    DateTime.parse(
                                      latestValidHistory['history_valid_to'],
                                    ),
                                  )
                                  : '';

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Card(
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

                              child:
                                  controller.trainee['status'] == 'NOT VALID'
                                      ? ListTile(
                                        onTap: () {
                                          Get.toNamed(
                                            AppRoutes.TC_PILOT_TRAINING_HISTORY,
                                            arguments: {
                                              'attendance':
                                                  controller
                                                      .trainingList[index],
                                              'idTrainee':
                                                  controller
                                                      .trainee['id_number'],
                                            },
                                          );
                                        },
                                        leading: Icon(
                                          CupertinoIcons.clear_circled_solid,
                                          color: ColorConstants.errorColor,
                                          size: 30,
                                        ),
                                        title: Text(
                                          controller
                                              .trainingList[index]['training'],
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 3,
                                            bottom: 5,
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorConstants
                                                          .searchFilled,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 3,
                                                    ),
                                                child: Text(
                                                  'NOT VALID',
                                                  style: GoogleFonts.notoSans(
                                                    fontSize: 12,
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: ColorConstants.hintColor,
                                          size: 18,
                                        ),
                                      )
                                      : isValid
                                      ? latestValidHistory != null &&
                                              latestValidHistory['history_valid_to'] !=
                                                  null
                                          ? (DateTime.parse(
                                                latestValidHistory['history_valid_to'],
                                              ).isAfter(DateTime.now()))
                                              ? ListTile(
                                                onTap: () {
                                                  Get.toNamed(
                                                    AppRoutes
                                                        .TC_PILOT_TRAINING_HISTORY,
                                                    arguments: {
                                                      'attendance':
                                                          controller
                                                              .trainingList[index],
                                                      'idTrainee':
                                                          controller
                                                              .trainee['id_number'],
                                                      'status': 'VALID',
                                                    },
                                                  );
                                                },
                                                leading: Icon(
                                                  Icons.check_circle,
                                                  color:
                                                      ColorConstants
                                                          .successColor,
                                                  size: 30,
                                                ),
                                                title: Text(
                                                  controller
                                                      .trainingList[index]['training'],
                                                  style: GoogleFonts.notoSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                subtitle: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 3,
                                                        bottom: 5,
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color:
                                                              ColorConstants
                                                                  .searchFilled,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 3,
                                                            ),
                                                        child: Text(
                                                          'VALID',
                                                          style: GoogleFonts.notoSans(
                                                            fontSize: 12,
                                                            color:
                                                                ColorConstants
                                                                    .textPrimary,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),

                                                      const SizedBox(width: 8),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color:
                                                              ColorConstants
                                                                  .searchFilled,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 3,
                                                            ),
                                                        child: Text(
                                                          historyDate.isNotEmpty
                                                              ? historyDate
                                                              : 'Unknown',
                                                          style: GoogleFonts.notoSans(
                                                            fontSize: 12,
                                                            color:
                                                                ColorConstants
                                                                    .textPrimary,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                trailing: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color:
                                                      ColorConstants.hintColor,
                                                  size: 18,
                                                ),
                                              )
                                              : ListTile(
                                                onTap: () {
                                                  Get.toNamed(
                                                    AppRoutes
                                                        .TC_PILOT_TRAINING_HISTORY,
                                                    arguments: {
                                                      'attendance':
                                                          controller
                                                              .trainingList[index],
                                                      'idTrainee':
                                                          controller
                                                              .trainee['id_number'],
                                                      'status': 'EXPIRED',
                                                    },
                                                  );
                                                },
                                                leading: Icon(
                                                  CupertinoIcons
                                                      .clear_circled_solid,
                                                  color:
                                                      ColorConstants.errorColor,
                                                  size: 30,
                                                ),
                                                title: Text(
                                                  controller
                                                      .trainingList[index]['training'],
                                                  style: GoogleFonts.notoSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                subtitle: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 3,
                                                        bottom: 5,
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color:
                                                              ColorConstants
                                                                  .searchFilled,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 3,
                                                            ),
                                                        child: Text(
                                                          'NOT VALID',
                                                          style: GoogleFonts.notoSans(
                                                            fontSize: 12,
                                                            color:
                                                                ColorConstants
                                                                    .textPrimary,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),

                                                      const SizedBox(width: 8),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color:
                                                              ColorConstants
                                                                  .searchFilled,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 3,
                                                            ),
                                                        child: Text(
                                                          'EXPIRED',
                                                          style: GoogleFonts.notoSans(
                                                            fontSize: 12,
                                                            color:
                                                                ColorConstants
                                                                    .textPrimary,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                trailing: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color:
                                                      ColorConstants.hintColor,
                                                  size: 18,
                                                ),
                                              )
                                          : ListTile(
                                            onTap: () {
                                              Get.toNamed(
                                                AppRoutes
                                                    .TC_PILOT_TRAINING_HISTORY,
                                                arguments: {
                                                  'attendance':
                                                      controller
                                                          .trainingList[index],
                                                  'idTrainee':
                                                      controller
                                                          .trainee['id_number'],
                                                },
                                              );
                                            },
                                            leading: Icon(
                                              CupertinoIcons
                                                  .clear_circled_solid,
                                              color: ColorConstants.errorColor,
                                              size: 30,
                                            ),
                                            title: Text(
                                              controller
                                                  .trainingList[index]['training'],
                                              style: GoogleFonts.notoSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 3,
                                                bottom: 5,
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          ColorConstants
                                                              .searchFilled,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 3,
                                                        ),
                                                    child: Text(
                                                      'NOT VALID',
                                                      style:
                                                          GoogleFonts.notoSans(
                                                            fontSize: 12,
                                                            color:
                                                                ColorConstants
                                                                    .textPrimary,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              color: ColorConstants.hintColor,
                                              size: 18,
                                            ),
                                          )
                                      : ListTile(
                                        onTap: () {
                                          Get.toNamed(
                                            AppRoutes.TC_PILOT_TRAINING_HISTORY,
                                            arguments: {
                                              'attendance':
                                                  controller
                                                      .trainingList[index],
                                              'idTrainee':
                                                  controller
                                                      .trainee['id_number'],
                                            },
                                          );
                                        },
                                        leading: Icon(
                                          CupertinoIcons.clear_circled_solid,
                                          color: ColorConstants.errorColor,
                                          size: 30,
                                        ),
                                        title: Text(
                                          controller
                                              .trainingList[index]['training'],
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 3,
                                            bottom: 5,
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorConstants
                                                          .searchFilled,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 3,
                                                    ),
                                                child: Text(
                                                  'NOT VALID',
                                                  style: GoogleFonts.notoSans(
                                                    fontSize: 12,
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: ColorConstants.hintColor,
                                          size: 18,
                                        ),
                                      ),
                            ),
                          );
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showLogoutDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                        
                            icon: Icon(
                              Icons.logout,
                              color: ColorConstants.textSecondary,
                            ),
                            label: Text(
                              'Logout',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textSecondary,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConstants.backgroundColor,
          shadowColor: ColorConstants.shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'Log Out',
            style: GoogleFonts.notoSans(
              color: ColorConstants.textPrimary,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.notoSans(
              color: ColorConstants.textPrimary,
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: GoogleFonts.notoSans(
                  color: ColorConstants.textPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(child: Loading());
                  },
                );

                await controller.logout();
                await Future.delayed(Duration(seconds: 2));

                Get.offAllNamed('/login');
                Get.snackbar(
                  'Logout',
                  'You have been logged out successfully',
                  backgroundColor: ColorConstants.primaryColor,
                  colorText: ColorConstants.textSecondary,
                  duration: const Duration(seconds: 3),
                  snackPosition: SnackPosition.TOP,
                );
              },

              child: Text(
                'Yes',
                style: GoogleFonts.notoSans(
                  color: ColorConstants.primaryColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
