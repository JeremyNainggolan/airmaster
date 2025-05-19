// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/ts_1/home/view/assessment/flight_details/controller/flightdetails_assessment_controller.dart';
import 'package:get/get.dart';

class FlightDetails_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlightDetails_Controller>(() => FlightDetails_Controller());
  }
}
