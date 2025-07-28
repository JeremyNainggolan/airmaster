import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TC_ProfilePilot_Controller extends GetxController {
  var trainee = RxMap<String, dynamic>();
  final trainingList = [].obs;
  final historyTraining = [].obs;
  final isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    trainee.value = Get.arguments ?? {};
    getTrainingList();
    log('Arguments: $trainee');
    await getParticipantHistory();
    log('History Trainingsss: $historyTraining');
    isLoading.value = false;
  }

  Future<List<dynamic>> getTrainingList() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_training_list),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      Map<String, dynamic> listTraining = jsonDecode(response.body);

      if (response.statusCode == 200) {
        trainingList.assignAll(listTraining['data']);
        log('Training List: $trainingList');
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

  Future<List<dynamic>> getParticipantHistory() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_participant_history,
        ).replace(queryParameters: {'idtraining': trainee['id_number']}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        historyTraining.assignAll(data['data']);
        return data['data'] ?? [];
      } else {
        log(
          'Failed to load participant training history: ${response.statusCode}',
        );
        return [];
      }
    } catch (e) {
      log('Error while fetching training list : $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>?> getHistoryData(
    String idTrainee,
    String subject,
    int longlist,
  ) async {
    String token = await UserPreferences().getToken();

    try {
      final url = Uri.parse(ApiConfig.get_history_training_trainee).replace(
        queryParameters: {
          'idtrainee': idTrainee,
          'subject': subject,
          'longlist': longlist.toString(),
        },
      );
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('Response body getHistoryData: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        final dataContent = data['data'];
        log('Data content: $dataContent');
        return [];
      } else {
        log('Failed to load history data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching history data: $e');
      return [];
    }
  }

  Future<String> eksportPDF(String idCrew) async {
    try {
      final List<Map<String, dynamic>>? historyDataBasicIndoc =
          await getHistoryData(idCrew, "BASIC INDOC", 1);
      final List<Map<String, dynamic>>? historyDataLSWB = await getHistoryData(
        idCrew,
        "LOAD SHEET / WEIGHT & BALANCE",
        1,
      );
      final List<Map<String, dynamic>>? historyDataRVSM = await getHistoryData(
        idCrew,
        "RVSM",
        1,
      );
      final List<Map<String, dynamic>>? historyDataWNDSHEAR =
          await getHistoryData(idCrew, "WNDSHEAR", 8);
      final List<Map<String, dynamic>>? historyDataAlarCfit =
          await getHistoryData(idCrew, "PBN/ALAR/CFIT", 4);
      final List<Map<String, dynamic>>? historyDataSEP = await getHistoryData(
        idCrew,
        "SEP",
        4,
      );
      final List<Map<String, dynamic>>? historyDataDRILL = await getHistoryData(
        idCrew,
        "DRILL",
        2,
      );
      final List<Map<String, dynamic>>? historyDataDGR = await getHistoryData(
        idCrew,
        "DGR",
        2,
      );
      final List<Map<String, dynamic>>? historyDataSMS = await getHistoryData(
        idCrew,
        "SMS",
        4,
      );
      final List<Map<String, dynamic>>? historyDataCRM = await getHistoryData(
        idCrew,
        "CRM",
        4,
      );
      final List<Map<String, dynamic>>? historyDataRNP = await getHistoryData(
        idCrew,
        "RNP",
        2,
      );
      final List<Map<String, dynamic>>? historyDataRGT = await getHistoryData(
        idCrew,
        "RGT",
        8,
      );
      final List<Map<String, dynamic>>? historyDataRHS = await getHistoryData(
        idCrew,
        "RHS CHECK (SIM)",
        8,
      );
      final List<Map<String, dynamic>>? historyDataUPRT = await getHistoryData(
        idCrew,
        "UPRT",
        2,
      );
      final List<Map<String, dynamic>>? historyDataAVSEC = await getHistoryData(
        idCrew,
        "AVSEC",
        4,
      );
      final List<Map<String, dynamic>>? historyDataLINECHECK =
          await getHistoryData(idCrew, "LINE CHECK", 4);
      final List<Map<String, dynamic>>? historyDataLVO = await getHistoryData(
        idCrew,
        "LVO",
        2,
      );
      final List<Map<String, dynamic>>? historyDataETOPSSIM =
          await getHistoryData(idCrew, "ETOPS SIM", 2);
      final List<Map<String, dynamic>>? historyDataETOPSFLT =
          await getHistoryData(idCrew, "ETOPS FLT", 2);

      RxMap<String, dynamic> usersData = trainee;

      String userName = "";
      String userLicense = "";
      String userEmp = "";
      // You can now work with the usersData list

      log('Trainee: $trainee');


      userName = usersData['name'] != null ? usersData['name'].toUpperCase() : "";
      userLicense = usersData['license_number'] ?? "";
      userEmp = usersData['id_number'] ?? "";

      final outputDirectory = await getTemporaryDirectory();
      // Load the existing PDF document.
      final ByteData data = await rootBundle.load(
        'assets/documents/TrainingCards.pdf',
      );
      final List<int> bytes = data.buffer.asUint8List();
      final PdfDocument document = PdfDocument(inputBytes: bytes);
      // Get the existing PDF page.
      final PdfPage page = document.pages[0];

      page.graphics.drawString(
        userName,
        PdfStandardFont(PdfFontFamily.helvetica, 6),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(412, 163, 300, 10.3),
      );

      page.graphics.drawString(
        userLicense,
        PdfStandardFont(PdfFontFamily.helvetica, 6),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(412, 173, 300, 10.3),
      );

      page.graphics.drawString(
        userEmp.toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 6),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(412, 183, 300, 10.3),
      );

      // Set the initial position for the table
      double x = 50;
      double y = 73;
      double cellWidth = 50;
      double cellHeight = 10.3;

      // --------------------AVSEC----------------
      for (var item in historyDataAVSEC!) {
        x = 105; // Reset x to the beginning of the row

        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------LINE CHECK----------------
      for (var item in historyDataLINECHECK!) {
        x = 105;

        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------LVO----------------
      for (var item in historyDataLVO!) {
        x = 105;

        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------ETOPS SIM----------------
      for (var item in historyDataETOPSSIM!) {
        x = 105;

        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------ETOPS FLT----------------
      for (var item in historyDataETOPSFLT!) {
        x = 105;

        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------Basic Indoc----------------
      for (var item in historyDataBasicIndoc!) {
        x = 105;
        y = 298;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          '-',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------LSWB----------------
      for (var item in historyDataLSWB!) {
        x = 105;
        y = 325;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          '-',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------RVSM----------------
      for (var item in historyDataRVSM!) {
        x = 105;
        y = 346;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          '-',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------WNDSHEAR----------------
      for (var item in historyDataWNDSHEAR!) {
        x = 105;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------AlarCfit----------------
      for (var item in historyDataAlarCfit!) {
        x = 105;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------SEP----------------
      for (var item in historyDataSEP!) {
        x = 268;
        y = 295;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------SEP DRILL----------------
      for (var item in historyDataDRILL!) {
        x = 268;
        y = 336;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------DGR----------------
      for (var item in historyDataDGR!) {
        x = 268;
        y = 356;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------SMS----------------
      for (var item in historyDataSMS!) {
        x = 268;
        y = 377;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------CRM----------------
      for (var item in historyDataCRM!) {
        x = 268;
        y = 418;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------PBN----------------
      for (var item in historyDataRNP!) {
        x = 268;
        y = 460;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------RGT----------------
      for (var item in historyDataRGT!) {
        x = 430;
        y = 295;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------RHS----------------
      for (var item in historyDataRHS!) {
        x = 430;
        y = 377;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // --------------------UPRT----------------
      for (var item in historyDataUPRT!) {
        x = 430;
        y = 460;
        page.graphics.drawString(
          item['date'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        x += cellWidth; // Move to the next column

        page.graphics.drawString(
          item['valid_to'] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(x, y, cellWidth, cellHeight),
        );

        // Move to the next row
        y += cellHeight;
      }

      // Save the document.
      final List<int> outputBytes = await document.save();
      final File file = File(
        '${outputDirectory.path}/TrainingCards$userName.pdf',
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
      // Handle the error as needed
    }
  }
}
