import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/view/detail_absent/view/training_history/view/detail_history/controller/history_controller.dart';
import 'package:get/get.dart';

class TC_Detail_TrainingHistory_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Detail_TrainingHistory_Controller>(
      () => TC_Detail_TrainingHistory_Controller(),
    );
  }
}