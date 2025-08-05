// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/services/auth/auth_service.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: EFB Profile Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the EFB Profile.
  | It is responsible for managing user profile data and actions.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-04-24
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class EFB_Profile_Controller extends GetxController {
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
  final status = ''.obs;
  final instructor = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  /// Loads user data asynchronously from user preferences and updates the corresponding observable fields.
  ///
  /// This method initializes the user preferences and retrieves various user-related information such as
  /// ID number, name, email, image URL, hub, LOA number, license number, license expiry, rank, status,
  /// and instructor list. The retrieved values are assigned to their respective observable variables.
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
    status.value = await _userPrefs.getStatus();
    instructor.assignAll(await _userPrefs.getInstructor());
  }

  /// Logs out the current user by calling the [AuthService.logout] method.
  ///
  /// If an error occurs during the logout process, it logs the error message.
  ///
  /// This method is asynchronous and should be awaited.
  Future<void> logout() async {
    try {
      await AuthService.logout();
    } catch (e) {
      log('Error clearing user data: $e');
    }
  }
}
