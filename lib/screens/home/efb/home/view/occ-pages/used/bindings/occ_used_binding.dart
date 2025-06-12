import 'package:airmaster/screens/home/efb/home/view/occ-pages/used/controller/occ_used_controller.dart';
import 'package:get/get.dart';

class OCC_Used_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OCC_Used_Controller>(() => OCC_Used_Controller());
  }
}
