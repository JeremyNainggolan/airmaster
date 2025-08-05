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
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/*
  |--------------------------------------------------------------------------
  | File: EFB Detail Feedback Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling feedback details in the EFB history view.
  | It is responsible for fetching feedback data, formatting it, and generating PDF documents.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-01
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Detail_Feedback_Controller extends GetxController {
  dynamic params = Get.arguments;

  final isLoading = true.obs;

  final rank = ''.obs;

  final history = {}.obs;
  final feedback = {}.obs;

  final format = {}.obs;

  final reqId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getRank();

    history.value = params['history'];
    reqId.value = params['request_id'];
    getFeedbackDetail(reqId.value);
  }

  /// Asynchronously retrieves the user's rank from preferences and updates the [rank] value.
  ///
  /// This method calls [UserPreferences.getRank] to fetch the rank and assigns it to [rank].
  /// It is intended to be used for updating the rank information in the controller.
  Future<void> getRank() async {
    rank.value = await UserPreferences().getRank();
  }

  /// Fetches the feedback detail for a given request ID.
  ///
  /// This method sets the [isLoading] flag to `true` while fetching data.
  /// It retrieves the authentication token from [UserPreferences], then
  /// sends an HTTP GET request to the feedback detail API endpoint with the
  /// provided [requestId] as a query parameter.
  ///
  /// If the response status code is 200, it updates the [feedback] value
  /// with the received data. Any errors encountered during the process are
  /// logged. The [isLoading] flag is reset to `false` after the operation.
  ///
  /// [requestId] - The ID of the feedback request to fetch details for.
  Future<void> getFeedbackDetail(String requestId) async {
    isLoading.value = true;
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_feedback_detail,
        ).replace(queryParameters: {'request_id': requestId}),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        feedback.value = responseData['data'];
      }
    } catch (e) {
      log('Error fetching feedback detail: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetches the PDF format data for the feedback form from the API.
  ///
  /// This method retrieves the authentication token, sends a GET request to the
  /// API endpoint specified in [ApiConfig.get_format_pdf] with the query parameter
  /// `id=feedback-form`, and includes the token in the request headers.
  ///
  /// If the request is successful (`statusCode == 200`), the response data is
  /// assigned to [format]. Otherwise, [format] is cleared. Any exceptions during
  /// the request also result in [format] being cleared.
  Future<void> getFormatPdf() async {
    final token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_format_pdf,
        ).replace(queryParameters: {'id': 'feedback-form'}),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        format.value = responseData['data'];
      } else {
        format.clear();
      }
    } catch (e) {
      format.clear();
    }
  }

  /// Formats a timestamp string into a human-readable date and time.
  ///
  /// The input [timestamp] should be in ISO 8601 format (e.g., "2023-06-01T14:30:00").
  /// Returns a string in the format "day/month/year at hour:minute".
  ///
  /// Example:
  ///   Input: "2023-06-01T14:30:00"
  ///   Output: "1/6/2023 at 14:30"
  String _formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);

    String formattedDateTime =
        '${dateTime.day}/${dateTime.month}/${dateTime.year}'
        ' at '
        '${dateTime.hour}:${dateTime.minute}';
    return formattedDateTime;
  }

  /// Generates a feedback PDF document based on the provided history and feedback data.
  ///
  /// This method performs the following steps:
  /// 1. Loads the required assets (logo image and custom font).
  /// 2. Constructs a PDF document using the `pdf` package, including:
  ///    - Header with logo, title, device information, and record details.
  ///    - Multiple tables and sections for feedback questions and answers.
  ///    - Footer with customizable left and right text.
  /// 3. Formats and inserts feedback data into the PDF, handling empty values gracefully.
  /// 4. Saves the generated PDF to the application's documents directory as `feedback-form.pdf`.
  /// 5. Opens the generated PDF file for viewing.
  ///
  /// Returns `true` if the document was created and opened successfully, otherwise returns `false`.
  ///
  /// Throws no exceptions; errors are caught and result in a `false` return value.
  Future<bool> createDocument() async {
    await getFormatPdf();

    try {
      await Future.microtask(() async {
        final rawLogo = await rootBundle.load(
          'assets/images/airasia_logo_circle.png',
        );
        final font = await rootBundle.load('assets/fonts/Poppins-Regular.ttf');

        final image = rawLogo.buffer.asUint8List();
        final ttf = pw.Font.ttf(font);

        final pdf = pw.Document();

        final footer = pw.Container(
          padding: const pw.EdgeInsets.all(5.0),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('${format['left_footer']}'),
              ),
              pw.Spacer(),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('${format['right_footer']}'),
              ),
            ],
          ),
        );

        pw.Widget bold(String text, pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerLeft,
            decoration: pw.BoxDecoration(border: pw.TableBorder.all()),
            padding: pw.EdgeInsets.all(5.0),
            child: pw.Text(
              text,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
            ),
          );
        }

        pw.Widget boldTitle(String text, pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            decoration: pw.BoxDecoration(border: pw.TableBorder.all()),
            padding: pw.EdgeInsets.all(5.0),
            child: pw.Text(
              text,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            ),
          );
        }

        pw.Widget reguler(String text, pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerLeft,
            decoration: pw.BoxDecoration(border: pw.TableBorder.all()),
            padding: pw.EdgeInsets.all(5.0),
            child: pw.Text(text, style: pw.TextStyle(fontSize: 9)),
          );
        }

        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (context) {
              return pw.Column(
                children: [
                  pw.Table(
                    tableWidth: pw.TableWidth.min,
                    border: pw.TableBorder.all(),
                    columnWidths: {0: pw.FlexColumnWidth(1)},
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Image(
                                  pw.MemoryImage(image),
                                  width: 65,
                                  height: 65,
                                ),
                              ],
                            ),
                          ),
                          pw.Expanded(
                            flex: 3,
                            child: pw.Padding(
                              padding: pw.EdgeInsets.symmetric(vertical: 5),
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Text(
                                    'IAA EFB',
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Text(
                                    'FEEDBACK FORM',
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Text(
                                    history['isFoRequest'] == true
                                        ? '${history['mainDeviceNo']} & ${history['backupDeviceNo']}'
                                        : '${history['deviceno'].toString().isEmpty ? '-' : history['deviceno']}',
                                    style: pw.TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 10,
                              ),
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        'Rec. No.',
                                        style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 8,
                                        ),
                                      ),
                                      pw.Text(
                                        '${format['rec_number'].toString().isEmpty ? '-' : format['rec_number']}',
                                        style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(height: 4),
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        'Date',
                                        style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 8,
                                        ),
                                      ),
                                      pw.Text(
                                        '${format['date'].toString().isEmpty ? '-' : format['date']}',
                                        style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(height: 4),
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        'Page',
                                        style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 8,
                                        ),
                                      ),
                                      pw.Text(
                                        '${format['page'].toString().isEmpty ? '-' : format['page']}',
                                        style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Align(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'Dear Pilots, The following test must be conducted on the IPAD PRO 10.5',
                      style: pw.TextStyle(font: ttf, fontSize: 11),
                    ),
                  ),
                  pw.Table(
                    tableWidth: pw.TableWidth.min,
                    border: pw.TableBorder.all(),
                    columnWidths: {
                      0: pw.FlexColumnWidth(1),
                      1: pw.FlexColumnWidth(2),
                      2: pw.FlexColumnWidth(1),
                      3: pw.FlexColumnWidth(2),
                    },
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Container(
                            height: 20.0,
                            child: reguler("DATE", context),
                          ),
                          pw.Container(
                            height: 20.0,
                            child: reguler(
                              feedback['feedback_date'].toString().isEmpty
                                  ? '-'
                                  : _formatTimestamp(
                                    '${feedback['feedback_date']}',
                                  ),
                              context,
                            ),
                          ),
                          pw.Container(
                            height: 20.0,
                            child: reguler("RANK", context),
                          ),
                          pw.Container(
                            height: 20.0,
                            child: reguler(
                              "${history['request_user_rank'].toString().isEmpty ? '-' : history['request_user_rank']}",
                              context,
                            ),
                          ),
                        ],
                      ),
                      pw.TableRow(
                        children: [
                          pw.Container(
                            height: 20.0,
                            child: reguler("Device No.", context),
                          ),

                          pw.Container(
                            height: 20.0,
                            child: reguler(
                              history['isFoRequest'] == true
                                  ? '${history['mainDeviceNo']} & ${history['backupDeviceNo']}'
                                  : history['deviceno'].toString().isEmpty
                                  ? '-'
                                  : history['deviceno'],
                              context,
                            ),
                          ),
                          pw.Container(
                            height: 20.0,
                            child: reguler("CREW NAME", context),
                          ),
                          pw.Container(
                            height: 20.0,
                            child: reguler(
                              "${history['request_user_name'].toString().isEmpty ? '-' : history['request_user_name']}",
                              context,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Table(
                    tableWidth: pw.TableWidth.min,
                    border: pw.TableBorder.all(),
                    columnWidths: {0: pw.FlexColumnWidth(1)},
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Container(
                            height: 25.0,
                            child: boldTitle('BATTERY INTEGRITY', context),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Table(
                    tableWidth: pw.TableWidth.min,
                    border: pw.TableBorder.all(),
                    columnWidths: {
                      0: pw.FlexColumnWidth(2),
                      1: pw.FlexColumnWidth(2),
                    },
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Column(
                            children: [
                              reguler(
                                "Do you charge the device during your duty?\n "
                                '${feedback['q1'].toString().isEmpty ? '-' : feedback['q1']}',
                                context,
                              ),
                              bold(
                                "If charging the device is REQUIRED.",
                                context,
                              ),
                              pw.Column(
                                children: [
                                  reguler(
                                    "1.  Flight Phase\n"
                                    '${feedback['q3'].toString().isEmpty ? '-' : feedback['q3']}',
                                    context,
                                  ),
                                  reguler(
                                    "2.  Charging duration\n"
                                    '${feedback['q4'].toString().isEmpty ? '-' : feedback['q4']}',
                                    context,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          pw.Column(
                            children: [
                              reguler(
                                "Do you find any risk or concern on the cabling?\n"
                                '${feedback['q2'].toString().isEmpty ? '-' : feedback['q2']}',
                                context,
                              ),
                              bold(
                                "If charging the device is NOT REQUIRED.",
                                context,
                              ),
                              pw.Column(
                                children: [
                                  reguler(
                                    "1.  Did you utilize ALL EFB software during your duty?\n"
                                    '${feedback['q5'].toString().isEmpty ? '-' : feedback['q5']}',
                                    context,
                                  ),
                                  reguler(
                                    "2.  Which software did you utilize the most?\n"
                                    '${feedback['q6'].toString().isEmpty ? '-' : feedback['q6']}',
                                    context,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Table(
                    tableWidth: pw.TableWidth.min,
                    border: pw.TableBorder.all(),
                    columnWidths: {0: pw.FlexColumnWidth(1)},
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Container(
                            height: 25.0,
                            child: boldTitle(
                              'BATTERY LEVEL AFTER ENGINE SHUTDOWN (with or without charging)',
                              context,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Table(
                    tableWidth: pw.TableWidth.min,
                    border: pw.TableBorder.all(),
                    columnWidths: {
                      0: pw.FlexColumnWidth(1),
                      1: pw.FlexColumnWidth(2),
                      2: pw.FlexColumnWidth(2),
                      3: pw.FlexColumnWidth(2),
                      4: pw.FlexColumnWidth(2),
                      5: pw.FlexColumnWidth(2),
                      6: pw.FlexColumnWidth(2),
                    },
                    children: [
                      pw.TableRow(
                        children: [
                          reguler("%", context),
                          reguler(
                            '1st   ${feedback['q7'].toString().isEmpty ? '-' : feedback['q7']}',
                            context,
                          ),
                          reguler(
                            '2nd   ${feedback['q8'].toString().isEmpty ? '-' : feedback['q8']}',
                            context,
                          ),
                          reguler(
                            '3rd   ${feedback['q9'].toString().isEmpty ? '-' : feedback['q9']}',
                            context,
                          ),
                          reguler(
                            '4th   ${feedback['q10'].toString().isEmpty ? '-' : feedback['q10']}',
                            context,
                          ),
                          reguler(
                            '5th   ${feedback['q11'].toString().isEmpty ? '-' : feedback['q11']}',
                            context,
                          ),
                          reguler(
                            '6th   ${feedback['q12'].toString().isEmpty ? '-' : feedback['q12']}',
                            context,
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Table(
                    tableWidth: pw.TableWidth.min,
                    border: pw.TableBorder.all(),
                    columnWidths: {0: pw.FlexColumnWidth(1)},
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Container(
                            height: 25.0,
                            child: boldTitle(
                              'VIEWABLE SOFTWARE INTEGRITY',
                              context,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Table(
                    tableWidth: pw.TableWidth.min,
                    border: pw.TableBorder.all(),
                    columnWidths: {0: pw.FlexColumnWidth(1)},
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Column(
                            children: [
                              reguler('''
Please observe the bracket and tick on your answer :

  1.  Strong Mechanical Integrity Flight
       ${feedback['q13'].toString().isEmpty ? '-' : feedback['q13']}
  2.  Easy to use
       ${feedback['q14'].toString().isEmpty ? '-' : feedback['q14']}
  3.  Easy to detached during emergency, if required
       ${feedback['q15'].toString().isEmpty ? '-' : feedback['q15']}
  4.  Obstruct emergency egress
       ${feedback['q16'].toString().isEmpty ? '-' : feedback['q16']}
  5.  Bracket position obstruct Pilot vision
       ${feedback['q17'].toString().isEmpty ? '-' : feedback['q17']} 
      (If Yes, How severe did it obstruct your vision)?
       ${feedback['q18'].toString().isEmpty ? '-' : feedback['q18']}
      (If high please write down your comment below)
       ${feedback['q19'].toString().isEmpty ? '-' : feedback['q19']}
''', context),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Table(
                    tableWidth: pw.TableWidth.min,
                    border: pw.TableBorder.all(),
                    columnWidths: {0: pw.FlexColumnWidth(1)},
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Container(
                            height: 25.0,
                            child: boldTitle('EFB SOFTWARE INTEGRITY', context),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Table(
                    tableWidth: pw.TableWidth.min,
                    border: pw.TableBorder.all(),
                    columnWidths: {0: pw.FlexColumnWidth(1)},
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Column(
                            children: [
                              reguler(
                                '  1.  Airbus Flysmart (Performance)' +
                                    "             ${feedback['q20'].toString().isEmpty ? '-' : feedback['q20']}\n" +
                                    '  2.  Lido (Navigation)' +
                                    "                                   ${feedback['q21'].toString().isEmpty ? '-' : feedback['q21']}\n" +
                                    '  3.  Vistair Docunet (Library Document)' +
                                    "      ${feedback['q22'].toString().isEmpty ? '-' : feedback['q22']}\n",
                                context,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Align(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'Additional comment on all observation : ${feedback['q23'].toString().isEmpty ? '-' : feedback['q23']}',
                      style: pw.TextStyle(font: ttf, fontSize: 8),
                    ),
                  ),
                  pw.SizedBox(height: 20.0),
                  pw.Column(children: [footer]),
                ],
              );
            },
          ),
        );

        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/feedback-form.pdf';
        final file = File(filePath);
        await file.writeAsBytes(await pdf.save());
        await OpenFile.open(filePath);
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
