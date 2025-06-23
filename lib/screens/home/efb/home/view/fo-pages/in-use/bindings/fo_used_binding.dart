import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/controller/fo_used_controller.dart';
import 'package:get/get.dart';

class Fo_Used_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Used_Controller>(() => Fo_Used_Controller());
  }
}
