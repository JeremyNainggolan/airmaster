// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/model/users/user.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Candidate_Controller extends GetxController {
  final formKey = GlobalKey<FormState>();

  final date = TextEditingController(
    text: DateFormatter.convertDateTimeDisplay(
      DateTime.now().toString(),
      "dd MMMM yyyy",
    ),
  );

  final firstFlightCrewName = TextEditingController();
  final firstFlightCrewStaffNumber = TextEditingController();
  final firstFlightCrewLicense = TextEditingController();
  final firstFlightCrewLicenseExpiry = TextEditingController();

  final secondFlightCrewName = TextEditingController();
  final secondFlightCrewStaffNumber = TextEditingController();
  final secondFlightCrewLicense = TextEditingController();
  final secondFlightCrewLicenseExpiry = TextEditingController();

  final aircraftType = TextEditingController();
  final airportAndRoute = TextEditingController();
  final simulationHours = TextEditingController();
  final simulationIdentity = TextEditingController();
  final loaNumber = TextEditingController();

  final candidate = {}.obs;

  Future<void> setCandidateAssessment() async {
    candidate.value = {
      'firstFlightCrewData': {
        'firstFlightCrewName': firstFlightCrewName.text,
        'firstFlightCrewStaffNumber': firstFlightCrewStaffNumber.text,
        'firstFlightCrewLicense': firstFlightCrewLicense.text,
        'firstFlightCrewLicenseExpiry': firstFlightCrewLicenseExpiry.text,
      },
      'SecondFlightCrewData': {
        'secondFlightCrewName': secondFlightCrewName.text,
        'secondFlightCrewStaffNumber': secondFlightCrewStaffNumber.text,
        'secondFlightCrewLicense': secondFlightCrewLicense.text,
        'secondFlightCrewLicenseExpiry': secondFlightCrewLicenseExpiry.text,
      },
      'aircraftData': {
        'aircraftType': aircraftType.text,
        'airportAndRoute': airportAndRoute.text,
        'simulationHours': simulationHours.text,
        'simulationIdentity': simulationIdentity.text,
        'loaNumber': loaNumber.text,
      },
    };
  }

  Future<List<User>> getUsersBySearchName(String searchName) async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_user_by_name,
        ).replace(queryParameters: {'name': searchName}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var usersRaw = responseData['data']['user'];
        List<User> users = User.resultSearchJson(usersRaw);
        return users;
      } else {
        log("API Error: ${response.body}");
        return [];
      }
    } catch (e) {
      log("Exception in getUsersBySearchName: $e");
      return [];
    }
  }
}
