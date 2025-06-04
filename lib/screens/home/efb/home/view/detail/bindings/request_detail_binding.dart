import 'package:airmaster/screens/home/efb/home/view/detail/controller/request_detail_controller.dart';
import 'package:get/get.dart';

class Detail_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Detail_Controller>(() => Detail_Controller());
  }
}
