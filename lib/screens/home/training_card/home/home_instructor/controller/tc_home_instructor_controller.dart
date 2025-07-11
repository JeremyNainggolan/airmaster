// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
