import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TC_AbsentParticipant_Controller extends GetxController {
  final participantId = Get.arguments; // data idattendace
  final dataAbsent = [].obs; // data participant yang tidak hadir
  final searchNameController = TextEditingController();
  final isLoading = false.obs;

  RxList<dynamic> trainee = [].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    await getAbsentParticipant();
    trainee.assignAll(dataAbsent);
    isLoading.value = false;
  }

  Future<void> getAbsentParticipant() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_absent_participant,
        ).replace(queryParameters: {'idattendance': participantId}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      log('Response body : ${response.body}');

      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200){
        dataAbsent.assignAll(data['data']);
      } else {
        log('Failed to load absent participants: ${response.body}');
      }
    } catch (e) {
      log('Error fetching absent participants: $e');
    }
  }

  void showFilteredTrainees(String query) {
    if (query.isEmpty) {
      trainee.assignAll(dataAbsent);
    } else {
      final lower = query.toLowerCase();
      trainee.assignAll(
        dataAbsent.where(
          (e) => (e['trainee_name'] ?? '').toLowerCase().contains(lower),
        ),
      );
    }
  }
}
