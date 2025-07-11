// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';
import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TC_Home_Administrator_Controller extends GetxController {
  final UserPreferences _userPrefs = UserPreferences();

  final attendanceWaiting = [].obs;
  final attendanceConfirmed = [].obs;

  var userId = ''.obs;
  var name = ''.obs;
  var email = ''.obs;
  var imgUrl = ''.obs;
  var hub = ''.obs;
  var loaNumber = ''.obs;
  var licenseNumber = ''.obs;
  var licenseExpiry = Rxn<DateTime>();
  var rank = ''.obs;
  var instructor = <String>[].obs;

  var greetings = ''.obs;

  final isLoading = false.obs;

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
    getStatusConfirmation();
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

  Future getStatusConfirmation() async {
    String token = await _userPrefs.getToken();
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_status_confirmation),
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      );
      log(jsonDecode(response.body).toString());

      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // log('Data: ${data['data']}');
        log('Training cards fetched successfully');
        attendanceConfirmed.clear();
        attendanceWaiting.clear();
        attendanceWaiting.addAll(data['data']['pending']);
        attendanceConfirmed.addAll(data['data']['confirmed']);
        isLoading.value = false;

        return data['data'];
      } else {
        log('Failed to fetch training cards: ${data['message']}');

        return false;
      }
    } catch (e) {
      log('Error fetching status confirmation: $e');
      return false;
    }
  }
}
