// ignore_for_file: camel_case_types

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/controller/tc_pilot_crew_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_PilotCrew extends GetView<TC_PilotCrew_Controller> {
  const TC_PilotCrew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
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
                      const SizedBox(height: 5),
                      Text(
                        'PILOT LIST',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
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
                            fontSize: 12,
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
                          child: Center(child: Text('No Trainees Found')),
                        ),
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
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ListTile(
                                  leading:
                                      controller.trainee[index]['photo_url'] !=
                                              null
                                          ? Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                controller
                                                    .trainee[index]['photo_url'],
                                              ),
                                              radius: 20,
                                            ),
                                          )
                                          : Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.blueGrey,
                                              child: Text(
                                                (controller.trainee[index]['name'] ??
                                                        '?')
                                                    .toString()
                                                    .substring(0, 1)
                                                    .toUpperCase(),
                                                style: GoogleFonts.notoSans(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),

                                  title: Text(
                                    controller.trainee[index]['name'] ?? '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.trainee[index]['id_number'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 13
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        decoration: BoxDecoration(
                                          color:
                                              controller.trainee[index]['status'] ==
                                                      'VALID'
                                                  ? ColorConstants.passColor
                                                  : ColorConstants.failColor,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2.0,
                                            horizontal: 12.0,
                                          ),
                                          child: Text(
                                            controller
                                                    .trainee[index]['status'] ??
                                                'N/A',
                                            style: TextStyle(
                                              color:
                                                  controller.trainee[index]['status'] ==
                                                          'VALID'
                                                      ? Colors.green
                                                      : Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () async {
                                    Get.toNamed(
                                      AppRoutes.TC_PROFILE_PILOT,
                                      arguments: controller.trainee[index],
                                    );
                                  },
                                ),
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
