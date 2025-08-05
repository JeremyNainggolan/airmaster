// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/services/auth/auth_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Profile Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the TC Profile feature.
  | It manages the state and logic for the profile operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Profile_Controller extends GetxController {
  final UserPreferences _userPrefs = UserPreferences();

  var userId = ''.obs;
  var name = ''.obs;
  var email = ''.obs;
  var imgUrl = ''.obs;
  var hub = ''.obs;
  var loaNumber = ''.obs;
  var licenseNumber = ''.obs;
  var licenseExpiryDate = Rxn<DateTime>();
  var rank = ''.obs;
  var instructor = <String>[].obs;
  var licenseExpiry = ''.obs;

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

    ever<DateTime?>(licenseExpiryDate, (date) {
      if (date != null) {
        licenseExpiry.value = DateFormat('dd MMMM yyyy').format(date);
      } else {
        licenseExpiry.value = '-';
      }
    });
  }

  /// Loads user data asynchronously from user preferences and updates the corresponding
  /// observable fields with the retrieved values. This includes user ID, name, email,
  /// image URL, hub, LOA number, license number, license expiry date, rank, and instructor list.
  Future<void> loadUserData() async {
    await _userPrefs.init();
    userId.value = await _userPrefs.getIdNumber();
    name.value = await _userPrefs.getName();
    email.value = await _userPrefs.getEmail();
    imgUrl.value = await _userPrefs.getImgUrl();
    hub.value = await _userPrefs.getHub();
    loaNumber.value = await _userPrefs.getLoaNumber();
    licenseNumber.value = await _userPrefs.getLicenseNumber();
    licenseExpiryDate.value = await _userPrefs.getLicenseExpiry();
    rank.value = await _userPrefs.getRank();
    instructor.assignAll(await _userPrefs.getInstructor());
  }

  /// Logs out the current user by calling the [AuthService.logout] method.
  ///
  /// If an error occurs during logout, it will be caught and logged.
  ///
  /// This method is asynchronous and returns a [Future] that completes when the logout process is finished.
  Future<void> logout() async {
    try {
      await AuthService.logout();
    } catch (e) {
      log('Error clearing user data: $e');
    }
  }
}
