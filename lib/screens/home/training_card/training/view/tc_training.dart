// ignore_for_file: camel_case_types

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/training/controller/tc_training_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_Training extends GetView<TC_Training_Controller> {
  const TC_Training({super.key});

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
                  onRefresh: controller.getTrainingCard,
                  color: ColorConstants.primaryColor,
                  backgroundColor: ColorConstants.backgroundColor,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverPadding(
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
                        ),

                      // Training Grid
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final item = controller.trainingList[index];
                            return GestureDetector(
                              onTap: () async {
                                final trainingName = item['training'];
                                final result = await Get.toNamed(
                                  AppRoutes.TC_TRAINING_LIST_DETAIL,
                                  arguments: trainingName,
                                );
                                if (result == true) {
                                  controller.getTrainingCard();
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
