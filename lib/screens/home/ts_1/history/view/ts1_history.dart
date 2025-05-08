// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/ts_1/history/controller/ts1_history_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class TS1_History extends GetView<TS1_History_Controller> {
  const TS1_History({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.backgroundColor,
      child: Center(
        child: Text(
          "TS1 - History Screen",
          style: TextStyle(color: ColorConstants.textPrimary),
        ),
      ),
    );
  }
}
