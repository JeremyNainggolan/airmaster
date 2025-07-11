// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/training_list/controller/tc_pilot_crew_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TC_TrainingList extends GetView<TC_TrainingList_Controller> {
  const TC_TrainingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.backgroundColor,
      child: Center(
        child: Text(
          "TC - Pilot Crew Screen",
          style: TextStyle(color: ColorConstants.textPrimary),
        ),
      ),
    );
  }
}
