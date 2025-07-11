// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TC_Home_Examinee_Controller extends GetxController {
  final UserPreferences _userPrefs = UserPreferences();
  var isLoading = false.obs;
  final feedbackRequired = [].obs;

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
    needFeedback();
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

  Future needFeedback() async {
    isLoading.value = true;
    String token = await _userPrefs.getToken();
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_need_feedback),
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      );

      log(jsonDecode(response.body).toString());
      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data['status'] == 'success') {
          feedbackRequired.assignAll(data['data']);
        } else {
          log("Errorini: ${data['message']}");
        }
      } else {
        log("Erroritu: ${data['message']}");
      }


    } catch (e) {
      log("Erroryglain: $e");
    }
  }
}
