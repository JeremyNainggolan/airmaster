import 'package:get/get.dart';

class OCC_Used_Controller extends GetxController {
  dynamic params = Get.arguments;

  final device = {}.obs;
  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }
}
