// ignore_for_file: camel_case_types

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';

class Detail_Controller extends GetxController {
  dynamic params = Get.arguments;

  final isFeedback = false.obs;

  final feedback = {}.obs;

  final device = {}.obs;

  final handOverTo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }

  Future<bool> returnOCC() async {
    String token = await UserPreferences().getToken();
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  Future<bool> returnOtherCrew() async {
    String token = await UserPreferences().getToken();
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
