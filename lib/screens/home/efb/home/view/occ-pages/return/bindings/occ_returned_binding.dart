import 'package:airmaster/screens/home/efb/home/view/occ-pages/return/controller/occ_returned_controller.dart';
import 'package:get/get.dart';

class OCC_Returned_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OCC_Returned_Controller>(() => OCC_Returned_Controller());
  }
}
