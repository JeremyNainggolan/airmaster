// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/home/home_instructor/controller/tc_home_instructor_controller.dart';
import 'package:get/get.dart';

class TC_Home_Instructor_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Home_Instructor_Controller>(() => TC_Home_Instructor_Controller());
  }
}
