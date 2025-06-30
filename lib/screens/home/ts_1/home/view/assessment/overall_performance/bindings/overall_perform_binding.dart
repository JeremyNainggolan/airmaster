import 'package:airmaster/screens/home/ts_1/home/view/assessment/overall_performance/controller/overall_perfom_controller.dart';
import 'package:get/get.dart';

class Overall_Perform_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Overall_Perfom_Controller>(() => Overall_Perfom_Controller());
  }
}
