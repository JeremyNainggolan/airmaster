// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
