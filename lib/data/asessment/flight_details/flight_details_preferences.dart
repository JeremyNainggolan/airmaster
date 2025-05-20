import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class FlightDetailsPreferences {
  static final FlightDetailsPreferences _instance =
      FlightDetailsPreferences._internal();
  SharedPreferences? _prefs;

  FlightDetailsPreferences._internal();

  factory FlightDetailsPreferences() {
    return _instance;
  }

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<bool> saveCandidate(Map<dynamic, dynamic> candidate) async {
    await init();
    await _prefs!.setString(
      'first_candidate_anotated',
      candidate['first_candidate']['anotated'].toString(),
    );
    await _prefs!.setString(
      'first_candidate_anotated_map',
      candidate['first_candidate']['anotated_map'].toString(),
    );
    await _prefs!.setString(
      'first_candidate_sub_anotated_map',
      candidate['first_candidate']['sub_anotated_map'].toString(),
    );
    await _prefs!.setString(
      'second_candidate_anotated',
      candidate['second_candidate']['anotated'].toString(),
    );
    await _prefs!.setString(
      'second_candidate_anotated_map',
      candidate['second_candidate']['anotated_map'].toString(),
    );
    await _prefs!.setString(
      'second_candidate_sub_anotated_map',
      candidate['second_candidate']['sub_anotated_map'].toString(),
    );
    return true;
  }

  Future<Map<String, dynamic>> getCandidate() async {
    await init();
    final firstCandidateAnotated =
        _prefs!.getString('first_candidate_anotated') ?? '';
    final firstCandidateAnotatedMap =
        _prefs!.getString('first_candidate_anotated_map') ?? '';
    final firstCandidateSubAnotatedMap =
        _prefs!.getString('first_candidate_sub_anotated_map') ?? '';
    final secondCandidateAnotated =
        _prefs!.getString('second_candidate_anotated') ?? '';
    final secondCandidateAnotatedMap =
        _prefs!.getString('second_candidate_anotated_map') ?? '';
    final secondCandidateSubAnotatedMap =
        _prefs!.getString('second_candidate_sub_anotated_map') ?? '';

    return {
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
  }

  Future<void> clear() async {
    await init();
    await _prefs!.remove('first_candidate_anotated');
    await _prefs!.remove('first_candidate_anotated_map');
    await _prefs!.remove('first_candidate_sub_anotated_map');
    await _prefs!.remove('second_candidate_anotated');
    await _prefs!.remove('second_candidate_anotated_map');
    await _prefs!.remove('second_candidate_sub_anotated_map');
    log("Flight details preferences cleared");
  }
}
