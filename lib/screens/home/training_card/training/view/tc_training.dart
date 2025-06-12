// ignore_for_file: camel_case_types

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/training/controller/tc_training_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:google_fonts/google_fonts.dart';

class TC_Training extends GetView<TC_Training_Controller> {
  const TC_Training({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: FutureBuilder(
        future: controller.getTrainingCard(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<dynamic> trainingList = snapshot.data as List<dynamic>;
            
            return RefreshIndicator(
              onRefresh: controller.getTrainingCard,
              color: ColorConstants.primaryColor,
              backgroundColor: ColorConstants.backgroundColor,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    // TITLE: Training List
                    Text(
                      'TRAINING LIST',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 12),
              
                    // GRID: Training Cards
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: trainingList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1.7,
                      ),
                      itemBuilder: (context, index) {
                        final item = trainingList[index];
                        return GestureDetector(
                          onTap: () {
                            final trainingName = item['training'];
                            Get.toNamed(AppRoutes.TC_TRAINING_LIST_DETAIL, arguments: trainingName);
                          },
                          child: Card(
                            color: ColorConstants.backgroundColorSecondary,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
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
                      },
                    ),
              
                    const SizedBox(height: 24),
              
                    // TITLE: Training Remark
                    Text(
                      'TRAINING REMARK',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 12),
              
                    // LIST: Training Remark Table
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.trainingRemarks.map((remark) {
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
                                  remark['desc']??'',
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: ColorConstants.primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}
