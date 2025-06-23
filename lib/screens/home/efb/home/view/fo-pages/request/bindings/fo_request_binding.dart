import 'package:airmaster/screens/home/efb/home/view/fo-pages/request/controller/fo_request_controller.dart';
import 'package:get/get.dart';

class Fo_Request_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Request_Controller>(() => Fo_Request_Controller());
  }
}
