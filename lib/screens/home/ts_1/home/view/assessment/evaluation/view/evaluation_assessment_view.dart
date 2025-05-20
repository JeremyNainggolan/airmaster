// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/ts_1/home/view/assessment/evaluation/controller/evaluation_assessment_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Evaluation_View extends GetView<Evaluation_Controller> {
  const Evaluation_View({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.backgroundColor,
      child: Center(
        child: Text(
          "TS1 - Evaluation Screen",
          style: TextStyle(color: ColorConstants.textPrimary),
        ),
      ),
    );
  }
}
