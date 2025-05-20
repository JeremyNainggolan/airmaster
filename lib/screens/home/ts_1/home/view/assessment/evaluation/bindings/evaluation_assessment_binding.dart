// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/ts_1/home/view/assessment/evaluation/controller/evaluation_assessment_controller.dart';
import 'package:get/get.dart';

class Evaluation_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Evaluation_Controller>(() => Evaluation_Controller());
  }
}
