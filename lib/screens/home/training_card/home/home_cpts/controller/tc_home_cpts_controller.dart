// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Home CPTS Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the TC Home CPTS feature.
  | It manages the state and logic for the home CPTS operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
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

  /// Loads user data asynchronously from user preferences and updates the corresponding
  /// observable fields with the retrieved values. This includes user ID, name, email,
  /// image URL, hub, LOA number, license number, license expiry, rank, and instructor list.
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

  /// Fetches the list of training cards from the API.
  ///
  /// Retrieves the user's authentication token and sends a GET request to the
  /// training cards endpoint. On success, parses the response and updates the
  /// `trainingList` and `trainingCount` with the fetched subjects.
  /// Returns the list of subjects including "ALL" as the first item.
  /// Logs errors or failure messages if the request is unsuccessful.
  ///
  /// Returns a [Future] that completes with a [List<String>] of subjects.
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

  /// Fetches the status confirmation for training cards from the API.
  ///
  /// Retrieves the user's authentication token and sends a GET request to the
  /// status confirmation endpoint. If the request is successful (HTTP 200),
  /// updates the `ongoingTrainingCount` with the number of pending training cards
  /// and returns the relevant data. If the request fails or an error occurs,
  /// logs the error and returns `false`.
  ///
  /// Returns a `Map<String, dynamic>` containing the status confirmation data
  /// on success, or `false` on failure.
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

  /// Fetches the total number of instructors by making an HTTP GET request to the pilot detail API.
  ///
  /// Retrieves the authentication token, sends a request to the API, and parses the response to extract
  /// instructor counts for various categories (FIS, FIA, GI, CCP, FO, CAPT). Updates the corresponding
  /// observable values with the fetched data. If the request fails or an error occurs, sets the instructor
  /// count to zero and logs the error.
  ///
  /// Throws no exceptions; errors are handled internally and logged.
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

  /// Fetches the list of pilots from the API and updates the [pilotCount] value.
  ///
  /// This method retrieves the authentication token from [UserPreferences], then
  /// sends a GET request to the pilot API endpoint. If the request is successful
  /// (status code 200), it decodes the response and updates [pilotCount] with the
  /// number of pilots received. If the request fails or an error occurs, it logs
  /// the error message.
  ///
  /// Exceptions are caught and logged for debugging purposes.
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

  /// Updates the currently selected subject.
  ///
  /// Sets the value of `_selectedSubject` to the provided [newSubject].
  /// This method can be used to change the subject selection in the UI.
  void updateSelectedSubject(String newSubject) {
    _selectedSubject.value = newSubject;
  }

  /// Refreshes the attendance data by fetching it again using the current
  /// values of [training], [from], and [to]. Updates [attendanceFuture]
  /// with the new fetch operation.
  void refreshAttendance() {
    attendanceFuture = fetchAttendanceData(
      trainingType: training.value,
      from: from.value,
      to: to.value,
    );
  }

  /// Resets the date filters and selections to their default values.
  ///
  /// - Sets `training` and `selectedSubject` to "ALL".
  /// - Sets `from` to January 1, 1900 and `to` to the current date.
  /// - Clears the text fields `fromC` and `toC`.
  /// - Refreshes the attendance data.
  void resetDate() {
    training.value = "ALL";
    selectedSubject.value = "ALL";
    from.value = DateTime(1900, 1, 1);
    to.value = DateTime.now();

    fromC.text = '';
    toC.text = '';
    refreshAttendance();
  }

  /// Fetches attendance data for a given training type within a specified date range.
  ///
  /// Makes an HTTP GET request to retrieve attendance information, including absent and present counts.
  ///
  /// Parameters:
  /// - [trainingType]: The type of training to filter attendance data.
  /// - [from]: The start date of the attendance period.
  /// - [to]: The end date of the attendance period.
  ///
  /// Updates [absentCount] and [presentCount] with the fetched data.
  /// Logs errors if the request fails or an exception occurs.
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
