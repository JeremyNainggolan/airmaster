// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: TC Home Examinee Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the TC Home Examinee feature.
  | It manages the state and logic for the home examinee operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
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
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    var hour = DateTime.now().hour;
    if (hour < 12) {
      greetings.value = "Morning";
    } else if (hour < 17) {
      greetings.value = "Afternoon";
    } else {
      greetings.value = "Evening";
    }

    await loadUserData();
    await needFeedback();
    isLoading.value = false;
  }

  /// Loads user data from shared preferences and updates the corresponding observable fields.
  ///
  /// This method initializes the user preferences and retrieves various user-related
  /// information such as ID number, name, email, image URL, hub, LOA number, license number,
  /// license expiry, rank, and instructor list. The retrieved values are assigned to their
  /// respective observable variables for use within the controller.
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

  /// Fetches the list of feedback required for the current trainee.
  ///
  /// This asynchronous method retrieves the authentication token and trainee ID from user preferences,
  /// then sends a GET request to the feedback API endpoint. If the request is successful (HTTP 200),
  /// it updates the `feedbackRequired` list with the received data. Otherwise, it clears the list and logs
  /// the error message. Any exceptions during the process are caught, the list is cleared, and the error is logged.
  Future needFeedback() async {
    String token = await _userPrefs.getToken();
    String idTrainee = await _userPrefs.getIdNumber();
    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_need_feedback,
        ).replace(queryParameters: {'idtraining': idTrainee}),
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      );

      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        feedbackRequired.clear();
        feedbackRequired.assignAll(data['data']);
        log("Feedback Required: $feedbackRequired");
      } else {
        feedbackRequired.clear();
        log("Erroritu: ${data['message']}");
      }
    } catch (e) {
      feedbackRequired.clear();
      log("Erroryglain: $e");
    }
  }
}
