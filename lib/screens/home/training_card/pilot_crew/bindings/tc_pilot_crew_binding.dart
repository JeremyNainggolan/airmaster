// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/pilot_crew/controller/tc_pilot_crew_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Pilot Crew Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Pilot Crew feature.
  | It manages the dependencies for the pilot crew controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_PilotCrew_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_PilotCrew_Controller>(() => TC_PilotCrew_Controller());
  }
}
