import 'package:airmaster/screens/home/efb/home/view/accept-handover/controller/accept_handover_controller.dart';
import 'package:get/get.dart';

class Accept_Handover_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Accept_Handover_Controller>(() => Accept_Handover_Controller());
  }
}
