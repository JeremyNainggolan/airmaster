import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/view/detail_absent/view/training_history/controller/tc_training_history_controller.dart';
import 'package:get/get.dart';

class TC_TrainingHistory_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_TrainingHistory_Controller>(
      () => TC_TrainingHistory_Controller(),
    );
  }
}
