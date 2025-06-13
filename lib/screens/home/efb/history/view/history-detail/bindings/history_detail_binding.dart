import 'package:airmaster/screens/home/efb/history/view/history-detail/controller/history_detail_controller.dart';
import 'package:get/get.dart';

class History_Detail_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<History_Detail_Controller>(() => History_Detail_Controller());
  }
}
