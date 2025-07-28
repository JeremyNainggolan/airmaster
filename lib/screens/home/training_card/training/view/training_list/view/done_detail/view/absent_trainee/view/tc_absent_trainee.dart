
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/controller/tc_absent_trainee_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_AbsentParticipant extends GetView<TC_AbsentParticipant_Controller> {
  const TC_AbsentParticipant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.activeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () => Get.back(),
        ),
        title: Text('Absent List'),
        titleTextStyle: GoogleFonts.notoSans(
          color: ColorConstants.textSecondary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
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
                          'Absent Trainees : ${controller.dataAbsent.length} Person',
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
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: ColorConstants.searchFilled,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: ColorConstants.searchFilled,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: ColorConstants.searchFilled,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: ColorConstants.searchFilled,
                              width: 2,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: ColorConstants.hintColor, 
                            fontSize: 12
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

                      if (controller.trainee.isEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(
                            child: 
                            Text('No Trainees Found'),
                          ),
                        )
                      ] else ...[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.trainee.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              color: ColorConstants.backgroundColor,
                              child: ListTile(
                                title: Text(
                                  controller.trainee[index]['trainee_name'] ??
                                      '',
                                ),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () async {
                                  Get.toNamed(AppRoutes.DETAIL_ABSENT_TRAINEE,
                                    arguments: controller.trainee[index]);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
      ),
    );
  }
}
