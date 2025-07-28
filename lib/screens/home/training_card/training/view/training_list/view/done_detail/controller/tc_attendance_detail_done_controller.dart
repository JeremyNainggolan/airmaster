import 'dart:developer';
import 'dart:convert';
import 'dart:io';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TC_AttendanceDetail_Done_Controller extends GetxController {
  final attendanceData = Get.arguments; // data dari attendance
  final isLoading = false.obs;

  final attendanceParticipant = [].obs; // data participant yang sudah hadir
  final totalTrainee = 0.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    await totalParticipant();
    log('AttendanceData: $attendanceData');
    totalTrainee.value = await totalAbsent();
    isLoading.value = false;
  }

  Future<int> totalParticipant() async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_total_participant_done,
        ).replace(queryParameters: {'_id': attendanceData['_id']}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        attendanceParticipant.assignAll(data['data']);
        return attendanceParticipant.length;
      } else {
        log('Failed to load participants: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      log('Error fetching participants: $e');
      return 0;
    }
  }

  Future<int> totalAbsent() async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_total_absent_trainee,
        ).replace(queryParameters: {'idattendance': attendanceData['_id']}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('Response body 1: ${response.body}');

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log('good : ${data['data']}');
        return data['data'];
      } else {
        log('Failed to load absent participants: ${response.body}');
        return 0;
      }
    } catch (e) {
      log('Error fetching absent participants: $e');
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getCombinedAttendanceDetailStream() async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_participant_detail,
        ).replace(queryParameters: {'idattendance': attendanceData['_id']}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('Response body 2: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final rawData = data['data'];
        if (rawData is List) {
          return List<Map<String, dynamic>>.from(rawData);
        }
      } else {
        log('Failed to load attendance details: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching attendance details: $e');
    }

    return [];
  }

  Future<Map<String, dynamic>?> administratorList() async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_administrator_data).replace(
          queryParameters: {
            'idPilotAdministrator': attendanceData['idPilotAdministrator'],
            '_id': attendanceData['_id'],
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('Response body 3: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Map<String, dynamic>.from(data['data']);
      } else {
        log('Failed to load administrator: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error fetching administrator: $e');
      return null;
    }
  }

  Future<String> eksportAttendanceListPDF() async {
    try {
      // get Attendance
      final Map<String, dynamic> attendanceModels = attendanceData;

      // get Attendance Detail (Daftar Training)
      final dynamic attendanceDetailStream =
          await getCombinedAttendanceDetailStream();

      // get Instructor
      final Map<String, dynamic>? instructorSt = attendanceData;

      // Memanggil Data Pilot Administrator
      final Map<String, dynamic>? administratorSt = await administratorList();

      final outputDirectory = await getTemporaryDirectory();
      // Load the existing PDF document.
      final ByteData data = await rootBundle.load(
        'assets/documents/AttendanceList.pdf',
      );
      final List<int> bytes = data.buffer.asUint8List();
      final PdfDocument document = PdfDocument(inputBytes: bytes);

      // Get the existing PDF page.
      final PdfPage page = document.pages[0];
      double x = 50;
      double cellWidth = 100;
      double cellHeight = 14.5;
      double y = 133;

      for (var item in [attendanceModels]) {
        log('Attendance Models: $item');
        x = 170;
        y = 133;

        var meeting = "square";
        var training = "square";

        if (item['attendanceType'] == 'Training') {
          training = "check";
        } else if (item['attendanceType'] == 'Meeting') {
          meeting = "check";
        }

        final ByteData datamtg = await rootBundle.load(
          'assets/images/$meeting.png',
        );
        final List<int> bytesmtg = datamtg.buffer.asUint8List();

        PdfBitmap imagemeeting = PdfBitmap(Uint8List.fromList(bytesmtg));

        page.graphics.drawImage(imagemeeting, Rect.fromLTWH(240, 117, 10, 10));

        final ByteData datatrn = await rootBundle.load(
          'assets/images/$training.png',
        );
        final List<int> bytestrn = datatrn.buffer.asUint8List();

        PdfBitmap imagetraining = PdfBitmap(Uint8List.fromList(bytestrn));

        page.graphics.drawImage(imagetraining, Rect.fromLTWH(310, 117, 10, 10));

        page.graphics.drawString(
          item['subject'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        y += cellHeight;
        page.graphics.drawString(
          item['department'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        y += cellHeight;
        page.graphics.drawString(
          item['trainingType'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x = 433;
        y = 133;
        page.graphics.drawString(
          DateFormat('dd MMMM yyyy').format(DateTime.parse(item['date'])),
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        y += cellHeight;
        page.graphics.drawString(
          item['venue'] ?? 'N/A',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        y += cellHeight;
        page.graphics.drawString(
          item['room'] ?? 'N/A',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );
      }

      y = 210;
      int ind = 1;
      //LIST OF TRAINEE
      for (var item in (attendanceDetailStream as Iterable)) {
        x = 60;

        page.graphics.drawString(
          ind.toString(),
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, 15, cellHeight),
        );

        x += 20;
        page.graphics.drawString(
          item?['trainee_name'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += 173;
        page.graphics.drawString(
          item?['idtraining'].toString() ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += 65;
        page.graphics.drawString(
          item?['trainee_rank'].toString() ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += 53;
        page.graphics.drawString(
          item?['trainee_loaNo'].toString() ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += 60;
        page.graphics.drawString(
          item?['trainee_hub'].toString() ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += 50;

        //Read the image data from the weblink.
        final filename = item['signature'];
        String token = await UserPreferences().getToken();

        final response = await http.get(
          Uri.parse(
            ApiConfig.get_tc_signature,
          ).replace(queryParameters: {'filename': filename}), headers: {
            'Authorization': 'Bearer $token',

          }
        );

        if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
          try {
            final PdfBitmap image = PdfBitmap(response.bodyBytes);
            page.graphics.drawImage(image, Rect.fromLTWH(x, y, 50, 15));
          } catch (e) {
            log('Error decoding signature $filename: $e');
            page.graphics.drawString(
              'Signature Error',
              PdfStandardFont(PdfFontFamily.helvetica, 8),
              bounds: Rect.fromLTWH(x, y, 50, 15),
            );
          }
        } else {
          log(' Signature not found or empty: $filename');
          page.graphics.drawString(
            'No signature',
            PdfStandardFont(PdfFontFamily.helvetica, 8),
            bounds: Rect.fromLTWH(x, y, 50, 15),
          );
        }

        ind++;
        y += cellHeight;
      }

      y = 581;
      //LIST OF TRAINER
      for (var item in [instructorSt]) {
        x = 59;

        log('Instructor: $item');

        page.graphics.drawString(
          item?['instructor_name'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += 195;
        page.graphics.drawString(
          item?['instructor'].toString() ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += 60;
        page.graphics.drawString(
          item?['instructor_loaNo'].toString() ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += 145;

        final filename = item?['signatureInstructor'];
        String token = await UserPreferences().getToken();

        final response = await http.get(
          Uri.parse(
            ApiConfig.get_tc_signature,
          ).replace(queryParameters: {'filename': filename}), headers: {
            'Authorization': 'Bearer $token',

          }
        );

        if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
          try {
            final PdfBitmap image = PdfBitmap(response.bodyBytes);
            page.graphics.drawImage(image, Rect.fromLTWH(x, y, 50, 15));
          } catch (e) {
            log('Error decoding signature $filename: $e');
            page.graphics.drawString(
              'Signature Error',
              PdfStandardFont(PdfFontFamily.helvetica, 8),
              bounds: Rect.fromLTWH(x, y, 50, 15),
            );
          }
        } else {
          log(' Signature not found or empty: $filename');
          page.graphics.drawString(
            'No signature',
            PdfStandardFont(PdfFontFamily.helvetica, 8),
            bounds: Rect.fromLTWH(x, y, 50, 15),
          );
        }
        y += cellHeight;
      }

      for (var item in [attendanceModels]) {
        x = 59;
        y = 640;

        page.graphics.drawString(
          item['remarks'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 8),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, 485, 35),
        );
      }

      y = 690;
      //LIST OF ADMIN
      for (var item in [administratorSt]) {
        x = 59;

        log('Administrator: $item');

        page.graphics.drawString(
          item?['administrator_name'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += 195;
        page.graphics.drawString(
          item?['administrator_id'].toString() ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += 205;

        final filename = item?['signaturePilotAdministrator'];
        String token = await UserPreferences().getToken();

        final response = await http.get(
          Uri.parse(
            ApiConfig.get_tc_signature,
          ).replace(queryParameters: {'filename': filename}), headers: {
            'Authorization': 'Bearer $token',

          }
        );

        if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
          try {
            final PdfBitmap image = PdfBitmap(response.bodyBytes);
            page.graphics.drawImage(image, Rect.fromLTWH(x, y, 50, 15));
          } catch (e) {
            log('Error decoding signature $filename: $e');
            page.graphics.drawString(
              'Signature Error',
              PdfStandardFont(PdfFontFamily.helvetica, 8),
              bounds: Rect.fromLTWH(x, y, 50, 15),
            );
          }
        } else {
          log(' Signature not found or empty: $filename');
          page.graphics.drawString(
            'No signature',
            PdfStandardFont(PdfFontFamily.helvetica, 8),
            bounds: Rect.fromLTWH(x, y, 50, 15),
          );
        }

        y += cellHeight;
      }

      // Save the document.
      final List<int> outputBytes = await document.save();
      final File file = File(
        '${outputDirectory.path}/AttendanceList-${attendanceData['_id']}.pdf',
      );
      await file.writeAsBytes(outputBytes);

      // Dispose the document.
      document.dispose();
      return file.path;
    } catch (e) {
      log("Error generating PDF: $e");
      return Future.value('');
    }
  }

  Future<void> openExportedPDF(String path) async {
    try {
      await OpenFile.open(path);
    } catch (e) {
      log("Error opening PDF: $e");
    }
  }
}
