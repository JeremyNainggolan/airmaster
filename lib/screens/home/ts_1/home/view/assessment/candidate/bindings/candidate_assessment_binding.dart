// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/ts_1/home/view/assessment/candidate/controller/candidate_assessment_controller.dart';
import 'package:get/get.dart';

class Candidate_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Candidate_Controller>(() => Candidate_Controller());
  }
}
