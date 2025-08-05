import 'dart:developer';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: EFB Main Controller
  |--------------------------------------------------------------------------
  | This file contains the main controller for the EFB (Electronic Flight Bag).
  | It is responsible for managing the state and logic of the EFB main screen.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-04-24
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class EFB_Main_Controller extends GetxController {
  final rank = ''.obs;

  @override
  void onInit() {
    super.onInit();
    rank.value = UserPreferences().getRank().toString();
    log(rank.value);
  }
}
