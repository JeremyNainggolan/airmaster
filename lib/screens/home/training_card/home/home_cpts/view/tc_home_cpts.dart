// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/home/home_cpts/controller/tc_home_cpts_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TC_Home_CPTS extends GetView<TC_Home_CPTS_Controller> {
  const TC_Home_CPTS({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.backgroundColor,
      child: Center(
        child: Text(
          "TC - Home CPTS's Screen",
          style: TextStyle(color: ColorConstants.textPrimary),
        ),
      ),
    );
  }
}
