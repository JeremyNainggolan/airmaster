import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/view/tc_pilot_training_history/controller/tc_pilot_training_history_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Pilot Training History Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Pilot Training History feature.
  | It manages the dependencies for the pilot training history controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_PilotTrainingHistory_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_PilotTrainingHistory_Controller>(
      () => TC_PilotTrainingHistory_Controller(),
    );
  }
}
