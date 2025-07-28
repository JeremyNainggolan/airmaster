import 'dart:convert';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:airmaster/config/api_config.dart';

class Ins_TotalTrainee_Controller extends GetxController {
  final isLoading = false.obs;
  dynamic dataTrainee = Get.arguments;
  final dataParticipant = [].obs;
  final totalParticipant = ''.obs;
  final searchNameController = TextEditingController();
  final selectedName = ''.obs;
  final traineeController = TextEditingController();
  final traineeDetails = [].obs;
  final subject = ''.obs;
  RxString type = ''.obs;

  RxList<dynamic> trainee = [].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    subject.value = dataTrainee['subject'] ?? '';
    type.value = await UserPreferences().getType();
    await setValue();
    await getTraineeDetails();
    trainee.assignAll(traineeDetails);
    log('Trainee Details: $traineeDetails');
    log('dataTrainee: $trainee');
    log('Pilot type: $type');
    isLoading.value = false;
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    await getTraineeDetails();
    trainee.assignAll(traineeDetails);
    isLoading.value = false;
  }

  void showFilteredTrainees(String query) {
    if (query.isEmpty) {
      trainee.assignAll(traineeDetails);
    } else {
      final lower = query.toLowerCase();
      trainee.assignAll(
        traineeDetails.where(
          (e) => (e['user_name'] ?? '').toLowerCase().contains(lower),
        ),
      );
    }
  }

  Future<void> setValue() async {
    dataParticipant.value = dataTrainee['dataParticipant'];
    totalParticipant.value = dataTrainee['totalTrainee'];
  }

  Future<List<dynamic>> getTraineeDetails() async {
    String token = await UserPreferences().getToken();

    try {
      final idTrainee = [];
      final idAttendance = [];
      for (var participant in dataParticipant) {
        idTrainee.add(participant['idtraining']);
        idAttendance.add(participant['id']);
      }


      final idTraineeQuery = idTrainee
          .map((id) => 'idtraining[]=$id')
          .join('&'); 

      final idAttendanceQuery = idAttendance
          .map((id) => '_id[]=$id')
          .join('&');

      log('id? : ${dataParticipant[0]['id']}');

      final String query = [idTraineeQuery, idAttendanceQuery]
      .where((q) => q.isNotEmpty)
      .join('&');

      final uri = Uri.parse('${ApiConfig.get_trainee_details}?$query');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      );

      Map<String, dynamic> dataTrainee = jsonDecode(response.body);

      if (response.statusCode == 200) {
        traineeDetails.clear();
        traineeDetails.addAll(dataTrainee['data']);
        log('data:$traineeDetails');
        return dataTrainee['data'];
      } else {
        log('error data');
        return [];
      }
    } catch (e) {
      log('Error fetching: $e');
    }
    return [];
  }
}
