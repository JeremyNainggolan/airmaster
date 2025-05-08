// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/ts_1/analytics/controller/ts1_analytics_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TS1_Analytics extends GetView<TS1_Analytics_Controller> {
  const TS1_Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.backgroundColor,
      child: Center(
        child: Text(
          "TS1 - Analytics Screen",
          style: TextStyle(color: ColorConstants.textPrimary),
        ),
      ),
    );
  }
}
