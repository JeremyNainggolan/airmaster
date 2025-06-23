import 'package:get/get.dart';

class Fo_Used_Controller extends GetxController {
  dynamic params = Get.arguments;

  final isFeedback = false.obs;

  final device = {}.obs;

  final feedback = {}.obs;

  final handOverTo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }
}
