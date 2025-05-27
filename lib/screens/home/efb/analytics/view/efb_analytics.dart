// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/analytics/controller/efb_analytics_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EFB_Analytics extends GetView<EFB_Analytics_Controller> {
  const EFB_Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Center(child: Text('Welcome to the EFB Analytics Screen!')),
    );
  }
}
