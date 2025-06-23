import 'package:airmaster/screens/home/efb/home/view/fo-pages/waiting-confirmation/controller/fo_waiting_controller.dart';
import 'package:get/get.dart';

class Fo_Waiting_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Waiting_Controller>(() => Fo_Waiting_Controller());
  }
}
