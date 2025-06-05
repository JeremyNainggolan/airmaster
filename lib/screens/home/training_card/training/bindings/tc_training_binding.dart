// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/training/controller/tc_training_controller.dart';
import 'package:get/get.dart';

class TC_Training_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Training_Controller>(() => TC_Training_Controller());
  }
}
