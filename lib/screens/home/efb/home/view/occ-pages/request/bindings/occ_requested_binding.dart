import 'package:airmaster/screens/home/efb/home/view/occ-pages/request/controller/occ_requested_controller.dart';
import 'package:get/get.dart';

class OCC_Requested_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OCC_Requested_Controller>(() => OCC_Requested_Controller());
  }
}
