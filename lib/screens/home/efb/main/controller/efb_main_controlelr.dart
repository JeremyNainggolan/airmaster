import 'dart:developer';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';

class EFB_Main_Controller extends GetxController {
  final rank = ''.obs;

  @override
  void onInit() {
    super.onInit();
    rank.value = UserPreferences().getRank().toString();
    log(rank.value);
  }
}
