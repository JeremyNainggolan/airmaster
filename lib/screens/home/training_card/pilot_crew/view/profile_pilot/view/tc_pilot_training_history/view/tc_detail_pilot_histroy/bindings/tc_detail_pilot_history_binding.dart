import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/view/tc_pilot_training_history/view/tc_detail_pilot_histroy/controller/tc_detail_pilot_history_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Detail Pilot History Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Detail Pilot History feature.
  | It manages the dependencies for the pilot training history detail controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Detail_PilotHistory_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Detail_PilotHistory_Controller>(
      () => TC_Detail_PilotHistory_Controller(),
    );
  }
}
