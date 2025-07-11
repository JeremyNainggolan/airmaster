// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:airmaster/helpers/qr_scanner.dart';
import 'package:airmaster/screens/home/training_card/training_list/controller/examainee_training_list_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';

class TC_TrainingList extends GetView<TC_TrainingList_Controller> {
  const TC_TrainingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getTrainingCard,
          color: ColorConstants.primaryColor,
          backgroundColor: ColorConstants.backgroundColor,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              if (controller.isLoading.value)
                SliverFillRemaining(
                  child: Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      color: ColorConstants.primaryColor,
                      size: 48,
                    ),
                  ),
                )
              else
                (SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TRAINING LIST',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                )),

              // Training Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = controller.trainingList[index];
                    return GestureDetector(
                      onTap: () async {
                        int status = await controller.getClassOpen(
                          '${item['training']}',
                        );
                        if (status == 1) {
                          log('Udah Ada kelas untuk training ini');
                          Get.toNamed(
                            AppRoutes.EXAMINEE_ATTENDANCE_DETAIL,
                            arguments: {
                              'attendanceDetail': controller.attendanceDetail,
                            },
                          );
                        } else if (status == 2) {
                          log('Minta Password');
                          QuickAlert.show(
                            barrierDismissible: false,
                            context: Get.context!,
                            type: QuickAlertType.info,
                            title: 'Training Details',
                            text:
                                'Please contact your instructor for the password.',
                            confirmBtnText: 'OK',
                            widget: Column(
                              children: [
                                TextField(
                                  controller: controller.passwordController,
                                  decoration: const InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: '',
                                    prefixIcon: Icon(Icons.lock_outline),
                                  ),
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () async {
                                    var code = await Get.to(() => QrScanner());
                                    log('QR Code: $code');
                                    controller.passwordController.text =
                                        code ?? '';
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorConstants.activeColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.qr_code,
                                        size: 25,
                                      ),
                                      title: Text(
                                        "Using QR Code",
                                        style: GoogleFonts.notoSans(
                                          color: ColorConstants.textPrimary,
                                        ),
                                      ),
                                      trailing: const Icon(Icons.navigate_next),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            showCancelBtn: true,
                            onCancelBtnTap: () {
                              controller.passwordController.clear();
                              Get.back();
                            },
                            cancelBtnTextStyle: GoogleFonts.notoSans(
                              color: ColorConstants.labelColor,
                              fontWeight: FontWeight.bold,
                            ),

                            onConfirmBtnTap: () async {
                              var data = await controller.checkClassPassword(
                                item['training'],
                                controller.passwordController.text,
                              );
                              if (data == 1) {
                                log('Pass');
                                var result = await Get.toNamed(
                                  AppRoutes.EXAMINEE_CREATE_ATTENDANCE,
                                  arguments: {
                                    'attendanceDetail':
                                        controller.attendanceDetail,
                                  },
                                );
                                if (result == true) {
                                  controller.refreshTrainingCard();
                                  Get.back();
                                }
                              } else if (data == 2) {
                                log('Salah Password');
                                Get.back();
                                controller.passwordController.clear();
                                QuickAlert.show(
                                  context: Get.context!,
                                  type: QuickAlertType.error,
                                  title: 'Password is wrong',
                                  text:
                                      'Get your password from your instructor',
                                  confirmBtnText: 'OK',
                                );
                              } else {
                                log('Error yang ini');
                              }
                            },

                            confirmBtnTextStyle: GoogleFonts.notoSans(
                              color: ColorConstants.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          log('Error occurred while checking class status');
                          QuickAlert.show(
                            context: Get.context!,
                            type: QuickAlertType.info,
                            title: 'Info',
                            text: 'No Clas Opened!',
                            confirmBtnText: 'OK',
                          );
                        }
                      },
                      child: Card(
                        color: ColorConstants.backgroundColorSecondary,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            SizeConstant.BORDER_RADIUS,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            item['training'] ?? '',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }, childCount: controller.trainingList.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1.7,
                  ),
                ),
              ),

              // Training Remark
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        'TRAINING REMARK',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...controller.trainingRemarks.map((remark) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 90,
                                child: Text(
                                  remark['code'] ?? '',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  remark['desc'] ?? '',
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.toNamed(AppRoutes.TC_NEW_TRAINING);
          if (result == true) {
            controller.getTrainingCard();
          }
        },
        child: Icon(Icons.add, size: 38.0, color: ColorConstants.whiteColor),
      ),
    );
  }
}
