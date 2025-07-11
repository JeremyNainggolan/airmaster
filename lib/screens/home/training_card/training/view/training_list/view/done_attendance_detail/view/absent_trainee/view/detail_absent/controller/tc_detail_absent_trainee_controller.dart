import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TC_Detail_AbsentTrainee_Controller extends GetxController {
  var trainee = RxMap<String, dynamic>();
  final trainingList = [].obs;

  @override
  void onInit() {
    super.onInit();
    trainee.value = Get.arguments ?? {};
    getTrainingList();
    log('Arguments: $trainee');
  }

  Future<List<dynamic>> getTrainingList() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_training_list),
        headers: {'Authorization': 'Bearer $token'},
      );

      Map<String, dynamic> listTraining = jsonDecode(response.body);
      

      if (response.statusCode == 200) {
        trainingList.assignAll(listTraining['data']);
        return [];
      } else {
        log('Failed to load training list: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching training list: $e');
      return [];
    }
  }
}
