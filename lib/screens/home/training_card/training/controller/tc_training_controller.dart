// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:airmaster/config/api_config.dart';

class TC_Training_Controller extends GetxController {

  List<Map<String, String>> trainingRemarks = [
  {'code': 'RVSM', 'desc': 'Reduced Vertical Separation Minima'},
  {'code': 'SEP', 'desc': 'Safety Emergency Procedures'},
  {'code': 'DGR', 'desc': 'Dangerous Goods and Regulations'},
  {'code': 'AVSEC', 'desc': 'Aviation Security'},
  {'code': 'SMS', 'desc': 'Safety Management System'},
  {'code': 'CRM', 'desc': 'Crew Resource Management'},
  {'code': 'ALAR/CFIT', 'desc': 'Approach and Landing Accident Reduction/Controlled Flight Into Terrain'},
  {'code': 'PBN', 'desc': 'Performance Based Navigation'},
  {'code': 'RGT', 'desc': 'Recurrent Ground Training'},
  {'code': 'RNAV (GNSS)', 'desc': 'Required Navigation (GNSS)'},
  {'code': 'LVO', 'desc': 'Low Visibility Operation'},
  {'code': 'RHS CHECK', 'desc': 'Right Hand Seat Check'},
  {'code': 'UPRT', 'desc': 'Upset and Recovery Training'},
];

  @override
  void onInit() {
    super.onInit();
    getTrainingCard();
  }
  Future getTrainingCard()async {
    String token = await UserPreferences().getToken();
    log('Token: $token');
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_training_cards),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });

        log(jsonDecode(response.body).toString());

        Map<String, dynamic> data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          // log('Data: ${data['data']}');
          log('Training cards fetched successfully');
        } else {
          log('Failed to fetch training cards: ${data['message']}');
        }

      return data['data'];
        
    } catch (e) {
      log('Error fetching training cards: $e');
    }

  }
}
