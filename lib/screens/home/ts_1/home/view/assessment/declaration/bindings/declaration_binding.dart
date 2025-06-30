import 'package:airmaster/screens/home/ts_1/home/view/assessment/declaration/controller/declaration_controller.dart';
import 'package:get/get.dart';

class Declaration_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Declaration_Controller>(() => Declaration_Controller());
  }
}
