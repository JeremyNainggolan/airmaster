// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/asessment/flight_details/flight_details_preferences.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/model/assessment/flight_details/flight_details.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FlightDetails_Controller extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await getFlightDetails();
  }

  final formKey = GlobalKey<FormState>();

  String firstCandidateAnotated = '';
  RxMap firstCandidateAnotatedMap = {}.obs;
  RxMap firstCandidateSubAnotatedMap = {}.obs;
  int firstCandidateIndex = 0;

  String secondCandidateAnotated = '';
  RxMap secondCandidateAnotatedMap = {}.obs;
  RxMap secondCandidateSubAnotatedMap = {}.obs;
  int secondCandidateIndex = 0;

  Future<void> getFlightDetails() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_flight_details),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> flightDetailsRawList = responseData['data'];
        final List<FlightDetails> flightDetailsList =
            flightDetailsRawList
                .map((item) => FlightDetails.fromJson(item))
                .toList();

        firstCandidateAnotatedMap.clear();
        secondCandidateAnotatedMap.clear();

        for (var item in flightDetailsList) {
          for (var detail in item.flightDetails) {
            firstCandidateAnotatedMap[detail.trim()] = false;
            secondCandidateAnotatedMap[detail.trim()] = false;

            var splitDetail = detail.split('/');

            if (splitDetail.length > 1) {
              Map<String, bool> subMap = {};
              for (var subDetail in splitDetail) {
                subMap[subDetail.trim()] = false;
              }
              firstCandidateSubAnotatedMap[detail
                  .trim()] = Map<String, bool>.from(subMap);
              secondCandidateSubAnotatedMap[detail
                  .trim()] = Map<String, bool>.from(subMap);
            }
          }
        }
      } else {
        log("API error: ${response.body}");
      }
    } catch (e) {
      log("Error fetching flight details: $e");
    }
  }

  Future<void> candidateAnotated() async {
    final candidateAnotated = {
      'first_candidate': {
        'anotated': firstCandidateAnotated,
        'anotated_map': firstCandidateAnotatedMap,
        'sub_anotated_map': firstCandidateSubAnotatedMap,
      },
      'second_candidate': {
        'anotated': secondCandidateAnotated,
        'anotated_map': secondCandidateAnotatedMap,
        'sub_anotated_map': secondCandidateSubAnotatedMap,
      },
    };

    await FlightDetailsPreferences().saveCandidate(candidateAnotated);

    log("Candidate anotated saved: $candidateAnotated");
  }

  Future<void> getValidation() async {
    firstCandidateIndex =
        firstCandidateAnotatedMap.values.where((value) => value == true).length;

    secondCandidateIndex =
        secondCandidateAnotatedMap.values
            .where((value) => value == true)
            .length;

    firstCandidateIndex +=
        firstCandidateSubAnotatedMap.values
            .expand((subMap) => subMap.values)
            .where((value) => value == true)
            .length;

    secondCandidateIndex +=
        secondCandidateSubAnotatedMap.values
            .expand((subMap) => subMap.values)
            .where((value) => value == true)
            .length;

    log("First Candidate Index: $firstCandidateIndex");
    log("Second Candidate Index: $secondCandidateIndex");
  }
}
