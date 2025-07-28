// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/pilot_crew/controller/tc_pilot_crew_controller.dart';
import 'package:get/get.dart';

class TC_PilotCrew_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_PilotCrew_Controller>(() => TC_PilotCrew_Controller());
  }
}
