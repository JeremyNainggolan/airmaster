import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/view/tc_pilot_training_history/view/tc_detail_pilot_histroy/controller/tc_detail_pilot_history_controller.dart';
import 'package:get/get.dart';

class TC_Detail_PilotHistory_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Detail_PilotHistory_Controller>(
      () => TC_Detail_PilotHistory_Controller(),
    );
  }
}