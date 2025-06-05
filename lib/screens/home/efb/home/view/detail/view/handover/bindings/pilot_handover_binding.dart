import 'package:airmaster/screens/home/efb/home/view/detail/view/handover/controller/pilot_handover_controller.dart';
import 'package:get/get.dart';

class Pilot_Handover_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Pilot_Handover_Controller>(() => Pilot_Handover_Controller());
  }
}
