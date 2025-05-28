// ignore_for_file: camel_case_types

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';

class TS1_Home_Controller extends GetxController {
  final UserPreferences _userPrefs = UserPreferences();

  final userId = ''.obs;
  final name = ''.obs;
  final email = ''.obs;
  final imgUrl = ''.obs;
  final hub = ''.obs;
  final loaNumber = ''.obs;
  final licenseNumber = ''.obs;
  final licenseExpiry = Rxn<DateTime>();
  final rank = ''.obs;
  final instructor = <String>[].obs;

  final greetings = ''.obs;

  @override
  void onInit() {
    super.onInit();

    var hour = DateTime.now().hour;
    if (hour < 12) {
      greetings.value = "Morning";
    } else if (hour < 17) {
      greetings.value = "Afternoon";
    } else {
      greetings.value = "Evening";
    }
    loadUserData();
  }

  Future<void> loadUserData() async {
    await _userPrefs.init();
    userId.value = await _userPrefs.getIdNumber();
    name.value = await _userPrefs.getName();
    email.value = await _userPrefs.getEmail();
    imgUrl.value = await _userPrefs.getImgUrl();
    hub.value = await _userPrefs.getHub();
    loaNumber.value = await _userPrefs.getLoaNumber();
    licenseNumber.value = await _userPrefs.getLicenseNumber();
    licenseExpiry.value = await _userPrefs.getLicenseExpiry();
    rank.value = await _userPrefs.getRank();
    instructor.assignAll(await _userPrefs.getInstructor());
  }
}
