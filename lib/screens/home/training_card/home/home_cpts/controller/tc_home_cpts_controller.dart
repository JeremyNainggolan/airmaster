// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TC_Home_CPTS_Controller extends GetxController {
  final UserPreferences _userPrefs = UserPreferences();
  Future<void> attendanceFuture = Future.value(); // inisialisasi default


  var userId = ''.obs;
  var name = ''.obs;
  var email = ''.obs;
  var imgUrl = ''.obs;
  var hub = ''.obs;
  var loaNumber = ''.obs;
  var licenseNumber = ''.obs;
  var licenseExpiry = Rxn<DateTime>();
  var rank = ''.obs;
  var instructor = <String>[].obs;
  RxInt touchedIndexPilot = (-1).obs;
  RxInt touchedIndexAttendance = (-1).obs;
  final isLoading = false.obs;

  final trainingCount = 0.obs;
  final ongoingTrainingCount = 0.obs;
  final instructorCount = 0.obs;
  final pilotCount = 0.obs;
  var trainingList = [].obs;
  final RxString _selectedSubject = "ALL".obs;
  RxString get selectedSubject => _selectedSubject;
  RxString training = "ALL".obs;
  late final Rx<DateTime> from = DateTime(1900, 1, 1).obs;
  late final Rx<DateTime> to = DateTime.now().obs;
  final fromC = TextEditingController();
  final toC = TextEditingController();

  final fisCount = 0.obs;
  final fiaCount = 0.obs;
  final giCount = 0.obs;
  final ccpCount = 0.obs;
  final foCount = 0.obs;
  final captCount = 0.obs;
  final absentCount = 0.obs;
  final presentCount = 0.obs;

  var greetings = ''.obs;

  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    attendanceFuture = fetchAttendanceData(
      trainingType: training.value,
      from: from.value,
      to: to.value,
    );
    await getTrainingCard();
    await getTotalInstructor();
    await getPilotList();
    await getStatusConfirmation();

    var hour = DateTime.now().hour;
    if (hour < 12) {
      greetings.value = "Morning";
    } else if (hour < 17) {
      greetings.value = "Afternoon";
    } else {
      greetings.value = "Evening";
    }
    loadUserData();

    isLoading.value = false;
  }

  Future<void> loadUserData() async {
    await _userPrefs.init();
    userId.value = await _userPrefs.getIdNumber();
    name.value = await _userPrefs.getName();
    email.value = await _userPrefs.getEmail();
    imgUrl.value = await _userPrefs.getImgUrl();
    hub.value = await _userPrefs.getHub();
    loaNumber.value = await _userPrefs.getLoaNumber();
    licenseNumber.value = await _userPrefs.getLicenseNumber();
    licenseExpiry.value = await _userPrefs.getLicenseExpiry();
    rank.value = await _userPrefs.getRank();
    instructor.assignAll(await _userPrefs.getInstructor());
  }

  Future getTrainingCard() async {
    List<String> subjects = ["ALL"];

    String token = await UserPreferences().getToken();
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_training_cards),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      // log('wawww : ${jsonDecode(response.body).toString()}');

      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // log('Training cards fetched successfullyy ');
        subjects.addAll(
          List<String>.from(
            data['data'].map((item) => item['training'].toString()),
          ),
        );
        trainingCount.value = subjects.length - 1;
        // log('Subjects: $subjects');
        // log('Training Count: ${trainingCount.value}');

        trainingList.value = subjects;

        return subjects;
      } else {
        log('Failed to fetch training cards: ${data['message']}');
      }
    } catch (e) {
      log('Error fetching training cards 1: $e');
    }
  }

  Future getStatusConfirmation() async {
    String token = await _userPrefs.getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_status_confirmation),
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      );
      // log(jsonDecode(response.body).toString());

      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // log('Data: ${data['data']}');
        // log('Training cards fetched successfullyy');
        ongoingTrainingCount.value = {data['data']['pending']}.length;

        // log('Pending: $ongoingTrainingCount');

        return data['data'];
      } else {
        log('Failed to fetch training cards: ${data['message']}');

        return false;
      }
    } catch (e) {
      log('Error fetching status confirmation: $e');
      return false;
    }
  }

  Future<void> getTotalInstructor() async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_pilot_detail),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      // log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final Map<String, dynamic> list = data['data'];
        log("Data fetched: ${list['FIS']}");

        fisCount.value = list['FIS'];
        fiaCount.value = list['FIA'];
        giCount.value = list['GI'];
        ccpCount.value = list['CCP'];
        foCount.value = list['FO'];
        captCount.value = list['CAPT'];

        instructorCount.value =
            fisCount.value + fiaCount.value + giCount.value + ccpCount.value;
      } else {
        log("Failed to fetch instructors: ${response.body}");
        ccpCount.value = 0;
      }
    } catch (e) {
      log('Error fetching instructors: $e');
      instructorCount.value = 0;
    }
  }

  Future<void> getPilotList() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_pilot_only),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // log('Pilot list fetched successfully: ${data['data']}');
        pilotCount.value = data['data'].length;
        // log('Pilot count: ${pilotCount.value}');
      } else {
        log('Failed to fetch pilot list: ${response.reasonPhrase}');
      }
    } catch (e) {
      log('Error fetching pilot list: $e');
    }
  }

  void updateSelectedSubject(String newSubject) {
    _selectedSubject.value = newSubject;
  }
   void refreshAttendance() {
    attendanceFuture = fetchAttendanceData(
      trainingType: training.value,
      from: from.value,
      to: to.value,
    );
  }

  void resetDate() {
    training.value = "ALL";
    selectedSubject.value = "ALL";
    from.value = DateTime(1900, 1, 1);
    to.value = DateTime.now();

    fromC.text = '';
    toC.text = '';
    refreshAttendance();
  }

  Future<void> fetchAttendanceData({
    required String trainingType,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final formatter = DateFormat('yyyy-MM-dd');
      final fromStr = formatter.format(from);
      final toStr = formatter.format(to);

      final response = await http.get(
        Uri.parse(ApiConfig.get_attendance_list_cpts).replace(
          queryParameters: {
            'trainingType': trainingType,
            'from': fromStr,
            'to': toStr,
          },
        ),
        headers: {
          'Authorization': 'Bearer ${await UserPreferences().getToken()}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        absentCount.value = data['absent'];
        presentCount.value = data['present'];

        // log("Data fetchedd: ${data['attendance']}");
      } else {
        log("API error: ${response.statusCode}");
      }
    } catch (e) {
      log("Fetch error: $e");
    }
  }
}
