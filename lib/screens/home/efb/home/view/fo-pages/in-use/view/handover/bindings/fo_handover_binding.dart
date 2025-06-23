import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/handover/controller/fo_handover_controller.dart';
import 'package:get/get.dart';

class Fo_Handover_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Handover_Controller>(() => Fo_Handover_Controller());
  }
}
