// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/controller/efb_home_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EFB_Home extends GetView<EFB_Home_Controller> {
  const EFB_Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Center(child: Text('Welcome to the EFB Home Screen!')),
    );
  }
}
