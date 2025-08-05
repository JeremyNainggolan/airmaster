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
  | File: TC Detail Training History Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the TC Detail Training History feature.
  | It manages the state and logic for the training history detail operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Detail_TrainingHistory_Controller extends GetxController {
  final historyTraining = Get.arguments;
  RxString instructorName = ''.obs;
  final isTrainee = false.obs;

  @override
  void onInit() {
    super.onInit();
    log('history: $historyTraining');
    getInstructorTraining();
  }

  /// Retrieves the instructor's name for a specific training session.
  ///
  /// This asynchronous method sends a GET request to the API endpoint defined in [ApiConfig.get_instructor_training],
  /// using the instructor ID from [historyTraining['history_instructor']] as a query parameter.
  /// The request includes an authorization token obtained from [UserPreferences].
  ///
  /// If the response is successful (HTTP 200), the instructor's name is extracted from the response body
  /// and assigned to [instructorName]. The name is also returned as a [String].
  ///
  /// Returns an empty string if the request fails or an exception occurs.
  ///
  /// Logs the response body and any errors encountered during the process.
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

  /// Retrieves the trainee's name for a specific training session.
  ///
  /// This asynchronous method sends an HTTP GET request to the API endpoint specified
  /// in [ApiConfig.get_trainee_training], including the training ID from [historyTraining].
  /// The request includes an authorization token obtained from [UserPreferences].
  ///
  /// If the response is successful (HTTP 200), it parses the JSON response and returns
  /// the trainee's name from the response data. If the request fails or an error occurs,
  /// it logs the error and returns an empty string.
  ///
  /// Returns a [Future] that completes with the trainee's name as a [String], or an empty
  /// string if the name cannot be retrieved.
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
  /// This method attempts to open the file and logs an error message if the operation fails.
  ///
  /// [path] The file system path to the PDF file to be opened.
  Future<void> openExportedPDF(String path) async {
    try {
      await OpenFile.open(path);
    } catch (e) {
      log("Error opening PDF: $e");
    }
  }

  /// Generates a certificate PDF for a trainee based on their training history.
  ///
  /// This method loads custom fonts and a background image, formats the certificate
  /// details (such as trainee name, certificate number, subject, training type, and date),
  /// and creates a styled PDF certificate using the `pdf` package.
  ///
  /// The generated PDF is saved to the temporary directory with a filename
  /// containing the trainee's name and training subject.
  ///
  /// Returns the file path of the saved PDF certificate on success, or an empty string on failure.
  ///
  /// Throws an [Exception] if the date format in the training history is unsupported.
  ///
  /// Example:
  /// ```dart
  /// String pdfPath = await createCertificate();
  /// ```
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
