import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/controller/tc_profile_pilot_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Profile Pilot Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Profile Pilot feature.
  | It manages the dependencies for the pilot profile controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_ProfilePilot_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_ProfilePilot_Controller>(() => TC_ProfilePilot_Controller());
  }
}
