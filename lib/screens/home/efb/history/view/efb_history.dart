// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/history/controller/efb_history_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EFB_History extends GetView<EFB_History_Controller> {
  const EFB_History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Center(child: Text('EFB History Screen')),
    );
  }
}
