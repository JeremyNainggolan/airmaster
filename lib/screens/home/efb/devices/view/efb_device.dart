// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/devices/controller/efb_device_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EFB_Device extends GetView<EFB_Device_Controller> {
  const EFB_Device({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Center(child: Text('Welcome to the EFB Device Screen!')),
    );
  }
}
