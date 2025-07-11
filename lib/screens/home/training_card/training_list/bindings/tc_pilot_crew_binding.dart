// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/training_list/controller/tc_pilot_crew_controller.dart';
import 'package:get/get.dart';

class TC_TrainingList_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_TrainingList_Controller>(() => TC_TrainingList_Controller());
  }
}
