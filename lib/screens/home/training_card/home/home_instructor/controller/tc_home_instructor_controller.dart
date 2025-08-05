// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: TC Home Instructor Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the TC Home Instructor feature.
  | It manages the state and logic for the home instructor operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Home_Instructor_Controller extends GetxController {
  final UserPreferences _userPrefs = UserPreferences();

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

  final isLoading = true.obs;
  final trainingOverviewList = [].obs;

  @override
  void onInit() async {
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
    getTrainingOverview(userId.value);
  }

  /// Loads user data from shared preferences and updates the corresponding observable fields.
  ///
  /// This method initializes the user preferences and retrieves various user-related information,
  /// such as ID number, name, email, image URL, hub, LOA number, license number, license expiry,
  /// rank, and instructor list. The retrieved values are assigned to their respective observable
  /// variables for use within the application.
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

  /// Fetches the training overview for a specific instructor by their [id].
  ///
  /// This method sends a GET request to the training overview API endpoint,
  /// including the instructor's ID as a query parameter and an authorization token in the headers.
  ///
  /// On a successful response (HTTP 200), it assigns the list of pending training overviews
  /// to [trainingOverviewList] and logs relevant information.
  ///
  /// If the response indicates an error or an exception occurs, it logs the error message.
  /// The [isLoading] observable is used to indicate the loading state throughout the process.
  ///
  /// Throws no exceptions; errors are logged and handled internally.
  Future getTrainingOverview(String id) async {
    log(id);
    String token = await _userPrefs.getToken();

    isLoading.value = true;

    try {
      final uri = Uri.parse(
        ApiConfig.get_training_overview,
      ).replace(queryParameters: {'instructor_id': id});

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      );

      log('data : ${jsonDecode(response.body).toString()}');

      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Handle successful response
        log("Training overview fetched successfully: ${data['message']}");
        trainingOverviewList.assignAll(data['data']['pending']);
        log('trainingOverviewList: $trainingOverviewList');
        isLoading.value = false;
      } else {
        // Handle error response
        log("Error fetching training overview: ${data['message']}");
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      log("Error fetching training overview: $e");
    }
  }
}
