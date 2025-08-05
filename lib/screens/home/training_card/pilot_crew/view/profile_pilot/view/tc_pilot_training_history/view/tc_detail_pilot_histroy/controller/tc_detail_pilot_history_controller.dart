import 'dart:developer';
import 'dart:io';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/*
  |--------------------------------------------------------------------------
  | File: TC Detail Pilot History Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the TC Detail Pilot History feature.
  | It manages the state and logic for the pilot detail history operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Detail_PilotHistory_Controller extends GetxController {
  final historyTraining = Get.arguments;
  RxString instructorName = ''.obs;
  final isTrainee = false.obs;

  @override
  void onInit() {
    super.onInit();
    log('history: $historyTraining');
    getInstructorTraining();
  }

  /// Retrieves the instructor's name for a specific training history.
  ///
  /// This asynchronous method sends a GET request to the instructor training API,
  /// using the instructor ID from `historyTraining['history_instructor']`.
  /// It includes the user's authentication token in the request headers.
  /// If the response is successful (HTTP 200), it parses the instructor's name
  /// from the response and updates the `instructorName` observable.
  /// Returns the instructor's name as a [String] if successful, or an empty string
  /// if an error occurs or the response is not successful.
  ///
  /// Returns:
  ///   A [Future] that completes with the instructor's name as a [String], or an empty string on failure.
  Future<String> getInstructorTraining() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_instructor_training).replace(
          queryParameters: {
            'instructor': historyTraining['history_instructor'],
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('Response bodyyy : ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        instructorName.value = data['data']['name'];
        log('Instructor Name: ${instructorName.value}');
        return instructorName.value;
      }
      return '';
    } catch (e) {
      log('Error: $e');
      return '';
    }
  }

  /// Retrieves the trainee's name associated with a specific training history.
  ///
  /// This asynchronous method sends an HTTP GET request to the API endpoint defined in [ApiConfig.get_trainee_training],
  /// including the training ID from [historyTraining]. It uses the user's token for authorization.
  /// If the request is successful (status code 200), it parses the response and returns the trainee's name.
  /// If the request fails or an exception occurs, it returns an empty string.
  ///
  /// Returns a [Future<String>] containing the trainee's name or an empty string if not found or on error.
  Future<String> getTraineeName() async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_trainee_training).replace(
          queryParameters: {'idtraining': historyTraining['idtraining']},
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('Response bodyyy : ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['data']['name'];
      }
      return '';
    } catch (e) {
      log('Error: $e');
      return '';
    }
  }

  /// Opens a PDF file located at the specified [path] using the default application.
  ///
  /// If an error occurs while attempting to open the file, it logs the error message.
  ///
  /// [path]: The file path of the PDF to be opened.
  Future<void> openExportedPDF(String path) async {
    try {
      await OpenFile.open(path);
    } catch (e) {
      log("Error opening PDF: $e");
    }
  }

  /// Generates a certificate PDF for a pilot training history.
  ///
  /// This method loads custom fonts and a background image, then creates a PDF document
  /// with the trainee's name, certificate number, training subject, type, duration, and date.
  /// The PDF is saved to a temporary directory and the file path is returned.
  ///
  /// Returns the file path of the generated certificate PDF, or an empty string if an error occurs.
  ///
  /// Throws an [Exception] if the date format in the training history is unsupported.
  Future<String> createCertificate() async {
    try {
      final font = await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
      final ttf = pw.Font.ttf(font);

      final fontBold = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");
      final ttfBold = pw.Font.ttf(fontBold);

      final pdf = pw.Document();
      final Uint8List backgroundImageData =
          (await rootBundle.load(
            'assets/images/Template-Certificate-Pilot.png',
          )).buffer.asUint8List();

      final Map<String, dynamic> certificateDate = historyTraining;
      var name = await getTraineeName(); // harus ganti nanti
      var formatNo = certificateDate['formatNo']; // ubah database
      var subject = certificateDate['history_subject'];
      var trainingType = certificateDate['history_training_type'];

      DateTime dates;
      var dateValue = certificateDate["history_date"];
      if (dateValue is DateTime) {
        dates = dateValue;
      } else if (dateValue is String) {
        dates = DateTime.parse(dateValue);
      } else {
        throw Exception("Unsupported date format");
      }
      var datePases = DateFormat('dd MMM yyyy').format(dates);

      String year = "";
      String month = "";
      month = DateFormat('MM').format(dates);
      year = DateFormat('yyyy').format(dates);

      String certificateNo = "IAA/FC/$formatNo/$month/$year";
      // ------------------- PDF ------------------
      pdf.addPage(
        pw.Page(
          pageTheme: const pw.PageTheme(
            pageFormat: PdfPageFormat(1122.17, 794),
            margin: pw.EdgeInsets.all(0),
          ),
          build: (pw.Context context) {
            final pageWidth = 1122.17;

            return pw.Stack(
              children: [
                pw.Image(
                  pw.MemoryImage(backgroundImageData),
                  fit: pw.BoxFit.cover,
                ),
                pw.Positioned(
                  top: 345,
                  child: pw.Container(
                    width: pageWidth,
                    child: pw.Center(
                      child: pw.Text(
                        name,
                        style: pw.TextStyle(
                          font: ttfBold,
                          fontSize: 32,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  top: 400,
                  child: pw.Container(
                    width: pageWidth,
                    child: pw.Center(
                      child: pw.Text(
                        "Certificate No:  $certificateNo",
                        style: pw.TextStyle(
                          font: ttfBold,
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  top: 460,
                  child: pw.Container(
                    width: pageWidth,
                    child: pw.Center(
                      child: pw.Text(
                        "Has successfully completed",
                        style: pw.TextStyle(font: ttf, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  top: 480,
                  child: pw.Container(
                    width: pageWidth,
                    child: pw.Center(
                      child: pw.Text(
                        "$subject $trainingType Training",
                        style: pw.TextStyle(font: ttf, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  top: 500,
                  child: pw.Container(
                    width: pageWidth,
                    child: pw.Center(
                      child: pw.Text(
                        "Conducted with total of 8 hours",
                        style: pw.TextStyle(font: ttf, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  top: 520,
                  child: pw.Container(
                    width: pageWidth,
                    child: pw.Center(
                      child: pw.Text(
                        "Date passes, $datePases",
                        style: pw.TextStyle(font: ttf, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
      final outputDirectory = await getTemporaryDirectory();
      // Save the document.
      final List<int> outputBytes = await pdf.save();
      final File file = File(
        '${outputDirectory.path}/Certificate-$name-$subject.pdf',
      );
      await file.writeAsBytes(outputBytes);
      return file.path;
    } catch (e) {
      log("Error generating PDF: $e");
      return Future.value('');
    }
  }
}
