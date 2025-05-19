// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/ts_1/home/view/assessment/flight_details/controller/flightdetails_assessment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlightDetails_View extends GetView<FlightDetails_Controller> {
  const FlightDetails_View({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Flight Details Assessment View')),
    );
  }
}
