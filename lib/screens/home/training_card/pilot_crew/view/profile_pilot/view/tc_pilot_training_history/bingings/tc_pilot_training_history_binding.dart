import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/view/tc_pilot_training_history/controller/tc_pilot_training_history_controller.dart';
import 'package:get/get.dart';

class TC_PilotTrainingHistory_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_PilotTrainingHistory_Controller>(
        () => TC_PilotTrainingHistory_Controller());
  }
}