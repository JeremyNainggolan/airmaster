// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/devices/controller/efb_device_controller.dart';
import 'package:get/get.dart';

class EFB_Device_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFB_Device_Controller>(() => EFB_Device_Controller());
  }
}
