
import 'package:airmaster/screens/home/training_card/training/view/training_list/controller/training_list_detail_controller.dart';
import 'package:get/get.dart';

class TC_TrainingListDetail_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_TrainingListDetail_Controller>(() => TC_TrainingListDetail_Controller());
  }
}
