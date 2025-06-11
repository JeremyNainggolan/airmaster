import 'package:airmaster/screens/home/efb/home/view/detail/view/return-occ/controller/occ_return_controller.dart';
import 'package:get/get.dart';

class Occ_Return_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Occ_Return_Controller>(() => Occ_Return_Controller());
  }
}
