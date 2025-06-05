// ignore_for_file: camel_case_types
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/controller/training_list_detail_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TC_TrainingListDetail extends GetView<TC_TrainingListDetail_Controller> {
  TC_TrainingListDetail({super.key});

  final trainingName = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () => Get.back(),
        ),
        title: Text('Training List $trainingName'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          PopupMenuButton<int>(
            color: ColorConstants.backgroundColor,
            icon: Icon(Icons.more_vert, color: ColorConstants.backgroundColor),
            onSelected: (item) => onSelected(context, item),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: ColorConstants.hintColor,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Add Training",
                            style: TextStyle(
                              color: ColorConstants.hintColor,
                              fontSize: SizeConstant.TEXT_SIZE,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: ColorConstants.hintColor,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),

                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: ColorConstants.hintColor,
                              fontSize: SizeConstant.TEXT_SIZE,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
    );
  }
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Get.toNamed(AppRoutes.TC_NEW_TRAINING);
      break;
    case 1:
      break;
  }
}
