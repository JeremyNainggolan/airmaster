import 'package:airmaster/screens/home/training_card/home/home_instructor/view/attendance_list/view/total_trainee/view/scoring_trainee/controller/scoring_trainee_controller.dart';
import 'package:get/get.dart';

class Ins_ScoringTrainee_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Ins_ScoringTrainee_Controller>(() => Ins_ScoringTrainee_Controller());
  }
}