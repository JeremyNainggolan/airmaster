import 'package:airmaster/screens/home/efb/history/controller/efb_history_controller.dart';
import 'package:get/get.dart';

class EFB_History_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFB_History_Controller>(() => EFB_History_Controller());
  }
}
