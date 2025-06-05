// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/training/view/new_training/controller/new_training_controller.dart';
import 'package:get/get.dart';

class TC_NewTraining_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_NewTrainingController>(() => TC_NewTrainingController());
  }
}
