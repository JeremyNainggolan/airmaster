import 'dart:developer';

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/home/home_instructor/view/attendance_list/view/total_trainee/controller/total_trainee_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Ins_TotalTrainee extends GetView<Ins_TotalTrainee_Controller> {
  const Ins_TotalTrainee({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.back(result: true);
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
            onPressed: () => Get.back(),
          ),
          title: const Text('Present Trainees'),
          titleTextStyle: GoogleFonts.notoSans(
            color: ColorConstants.textSecondary,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: ColorConstants.primaryColor,
        ),
        body: Obx(
          () =>
              controller.isLoading.value == true
                  ? Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      color: ColorConstants.primaryColor,
                      size: 48,
                    ),
                  )
                  : SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 12,
                      right: 12,
                      bottom: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorConstants.backgroundColor,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: ColorConstants.labelColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Present Trainees : ${controller.totalParticipant.value} Person',
                            style: TextStyle(
                              color: ColorConstants.textPrimary,
                              fontSize: SizeConstant.TEXT_SIZE_HINT,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextFormField(
                          onChanged:
                              (value) => controller.showFilteredTrainees(value),
                          decoration: InputDecoration(
                            labelText: 'Search Trainee Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: ColorConstants.labelColor,
                                width: 1,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: ColorConstants.blackColor,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: ColorConstants.blackColor,
                              ),
                              onPressed: () {
                                controller.searchNameController.clear();
                                controller.showFilteredTrainees('');
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.trainee.length,
                          itemBuilder: (context, index) {
                            if (controller.trainee[index]['status'] == 'done') {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                                color: ColorConstants.backgroundColor,
                                child: ListTile(
                                  title: Text(
                                    controller.trainee[index]['user_name'] ??
                                        '',
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () async {
                                    var result = await Get.toNamed(
                                      AppRoutes.SCORING_TRAINEE,
                                      arguments: {
                                        'idTrainee':
                                            controller
                                                .trainee[index]['idtraining'],
                                        'idattendance-detail':
                                            controller.trainee[index]['_id'],
                                        'subject': controller.subject.value,
                                      },
                                    );
                                    log('result: $result');

                                    if (result == true) {
                                      controller.refreshData();
                                    }
                                  },
                                ),
                              );
                            } else {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                                color: ColorConstants.backgroundColor,
                                child: ListTile(
                                  title: Text(
                                    controller.trainee[index]['user_name'] ??
                                        '',
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap:
                                      controller.type.value != 'Administrator'
                                          ? () async {
                                            var result = await Get.toNamed(
                                              AppRoutes.SCORING_TRAINEE,
                                              arguments: {
                                                'idTrainee':
                                                    controller
                                                        .trainee[index]['idtraining'],
                                                'idattendance-detail':
                                                    controller
                                                        .trainee[index]['_id'],
                                              },
                                            );

                                            log('result: $result');
                                            if (result == true) {
                                              controller.refreshData();
                                            }
                                          }
                                          : () {},
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                controller.trainee[index]['score'] ==
                                                        'PASS'
                                                    ? ColorConstants.passColor
                                                    : ColorConstants.failColor,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Text(
                                            controller
                                                    .trainee[index]['score'] ??
                                                'N/A',
                                            style: TextStyle(
                                              color:
                                                  controller.trainee[index]['score'] ==
                                                          'PASS'
                                                      ? Colors.green
                                                      : Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.yellow.shade100,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Text(
                                            controller.trainee[index]['grade']
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
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
