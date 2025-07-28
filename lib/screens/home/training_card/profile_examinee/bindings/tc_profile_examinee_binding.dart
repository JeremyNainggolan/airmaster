import 'package:airmaster/screens/home/training_card/profile_examinee/controller/tc_profile_examinee_controller.dart';
import 'package:get/get.dart';

class TC_ProfileExaminee_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_ProfileExaminee_Controller>(
      () => TC_ProfileExaminee_Controller(),
    );
  }
}
