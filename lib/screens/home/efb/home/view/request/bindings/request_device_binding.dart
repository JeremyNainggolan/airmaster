// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/view/request/controller/request_device_controller.dart';
import 'package:get/get.dart';

class Request_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Request_Controller>(() => Request_Controller());
  }
}
