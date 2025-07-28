import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/controller/tc_profile_pilot_controller.dart';
import 'package:get/get.dart';

class TC_ProfilePilot_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_ProfilePilot_Controller>(() => TC_ProfilePilot_Controller());
  }
}