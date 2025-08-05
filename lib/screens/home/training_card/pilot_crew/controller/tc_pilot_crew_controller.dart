// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: TC Pilot Crew Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the TC Pilot Crew feature.
  | It manages the state and logic for the pilot crew operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_PilotCrew_Controller extends GetxController {
  final isLoading = false.obs;
  final pilotList = [].obs;
  final trainee = [].obs;
  final searchNameController = TextEditingController();

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    await getPilotList();
    trainee.assignAll(pilotList);
    isLoading.value = false;
  }

  /// Fetches the list of pilots from the API and updates [pilotList].
  ///
  /// Retrieves the authentication token from [UserPreferences], then sends a GET request
  /// to the [ApiConfig.get_all_pilot] endpoint with the appropriate headers.
  /// If the response is successful (status code 200), parses the JSON response and
  /// assigns the pilot data to [pilotList]. Logs an error message if the request fails
  /// or if an exception occurs during the process.
  Future<void> getPilotList() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_all_pilot),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        pilotList.assignAll(data['data']);
      } else {
        log('Failed to fetch pilot list: ${response.reasonPhrase}');
      }
    } catch (e) {
      log('Error fetching pilot list: $e');
    }
  }

  /// Filters the list of trainees based on the provided [query].
  ///
  /// If [query] is empty, all pilots from [pilotList] are assigned to [trainee].
  /// Otherwise, only pilots whose 'name' starts with the lowercase [query] are assigned.
  ///
  /// [query]: The search string used to filter trainee names.
  void showFilteredTrainees(String query) {
    if (query.isEmpty) {
      trainee.assignAll(pilotList);
    } else {
      final lower = query.toLowerCase();
      trainee.assignAll(
        pilotList.where(
          (e) => (e['name'] ?? '').toLowerCase().startsWith(lower),
        ),
      );
    }
  }
}
