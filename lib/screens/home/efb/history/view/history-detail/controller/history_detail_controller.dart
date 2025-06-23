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

class History_Detail_Controller extends GetxController {
  dynamic params = Get.arguments;

  final detail = {}.obs;

  final rank = ''.obs;

  final format = {}.obs;

  Rx<Uint8List?> img = Rx<Uint8List?>(null);

  @override
  void onInit() {
    super.onInit();
    getRank();
    detail.value = params['detail'];
    log('Detail: ${detail.toString()}');
  }

  Future<void> getRank() async {
    rank.value = await UserPreferences().getRank();
  }

  Future<void> getImage(String imgName) async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_device_image,
        ).replace(queryParameters: {'img_name': imgName}),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        img.value = response.bodyBytes;
        log('Image fetched successfully: ${img.value?.length} bytes');
      }
    } catch (e) {
      log('Error fetching image: $e');
    }
  }

  Future<void> getFormatPdf() async {
    final token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_format_pdf,
        ).replace(queryParameters: {'id': 'handover-log'}),
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

  String _formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);

    String formattedDateTime =
        '${dateTime.day}/${dateTime.month}/${dateTime.year}'
        ' at '
        '${dateTime.hour}:${dateTime.minute}';
    return formattedDateTime;
  }

  Future<Uint8List> fetchImage(String imageUrl) async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_signature_image,
        ).replace(queryParameters: {'img_name': imageUrl}),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        return Uint8List(0);
      }
    } catch (e) {
      return Uint8List(0);
    }
  }

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

        pw.Widget buildHeaderCell(String text, pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            decoration: pw.BoxDecoration(border: pw.TableBorder.all()),
            padding: const pw.EdgeInsets.all(5.0),
            child: pw.Text(
              text,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
            ),
          );
        }

        pw.Widget buildHeaderCellLeft(String text, pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerLeft,
            decoration: pw.BoxDecoration(border: pw.TableBorder.all()),
            padding: const pw.EdgeInsets.all(5.0),
            child: pw.Text(
              text,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            ),
          );
        }

        pw.Widget buildHeaderCellRight(String text, pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerLeft,
            decoration: pw.BoxDecoration(border: pw.TableBorder.all()),
            padding: const pw.EdgeInsets.all(5.0),
            child: pw.Text(text, style: const pw.TextStyle(fontSize: 10)),
          );
        }

        pw.Widget requestUserSignatureWidget;
        if (detail['request_user_signature'] != null) {
          try {
            final imageBytes = await fetchImage(
              detail['request_user_signature'],
            );
            final image = pw.MemoryImage(imageBytes);
            requestUserSignatureWidget = pw.Image(image);
          } catch (e) {
            requestUserSignatureWidget = pw.Text(
              'Failed to load signature image',
            );
          }
        } else {
          requestUserSignatureWidget = pw.Text('No signature available');
        }

        pw.Widget occSignatureWidget;
        if (detail['received_signature'] != null) {
          try {
            final imageBytes = await fetchImage(detail['received_signature']);
            final image = pw.MemoryImage(imageBytes);
            occSignatureWidget = pw.Image(image);
          } catch (e) {
            occSignatureWidget = pw.Text('Failed to load signature image');
          }
        } else {
          occSignatureWidget = pw.Text('No signature available');
        }

        pw.Widget otherCrewSignatureWidget;
        if (detail['handover_signature'] != null) {
          log('Fetching other crew signature: ${detail['handover_signature']}');
          try {
            final imageBytes = await fetchImage(detail['handover_signature']);
            final image = pw.MemoryImage(imageBytes);
            otherCrewSignatureWidget = pw.Image(image);
          } catch (e) {
            otherCrewSignatureWidget = pw.Text(
              'Failed to load signature image',
            );
          }
        } else {
          otherCrewSignatureWidget = pw.Text('No signature available');
        }

        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.letter.copyWith(
              marginLeft: 72.0,
              marginRight: 72.0,
              marginTop: 36.0,
              marginBottom: 36.0,
            ),
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
                              padding: pw.EdgeInsets.symmetric(vertical: 15.0),
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Text(
                                    'IAA EFB',
                                    style: pw.TextStyle(
                                      // font: ttf,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Text(
                                    'Handover Log',
                                    style: pw.TextStyle(
                                      // font: ttf,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
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
                                        format['rec_number'],
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
                                        format['date'],
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
                                        format['page'],
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
                  pw.SizedBox(height: 20),
                  pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      'EFB Handover Log',
                      style: pw.TextStyle(
                        fontSize: 30,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  if (detail['isFoRequest']) ...[
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Align(
                          child: pw.Text(
                            '2nd & 3rd Device',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.Align(
                          child: pw.Text(
                            detail['received_at'] == null
                                ? _formatTimestamp(detail['handover_date'])
                                : _formatTimestamp(detail['received_at']),
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.Table(
                      tableWidth: pw.TableWidth.min,
                      border: pw.TableBorder.all(),
                      columnWidths: {0: const pw.FlexColumnWidth(1)},
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 25.0,
                              child: buildHeaderCell('EFB Device', context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    pw.Table(
                      tableWidth: pw.TableWidth.min,
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: const pw.FlexColumnWidth(2),
                        1: const pw.FlexColumnWidth(3),
                        2: const pw.FlexColumnWidth(2),
                        3: const pw.FlexColumnWidth(3),
                      },
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Device No 2',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['mainDeviceNo'] ?? 'N/A',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Device No 3',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['backupDeviceNo'] ?? 'N/A',
                                context,
                              ),
                            ),
                          ],
                        ),
                        // pw.TableRow(
                        //   children: [
                        //     pw.Container(
                        //       height: 20.0,
                        //       child: _buildHeaderCellLeft('Charger No 2', context),
                        //     ),
                        //     pw.Container(
                        //       height: 20.0,
                        //       child: _buildHeaderCellRight('xxxx', context),
                        //     ),
                        //     pw.Container(
                        //       height: 20.0,
                        //       child: _buildHeaderCellLeft('Charger No 3', context),
                        //     ),
                        //     pw.Container(
                        //       height: 20.0,
                        //       child: _buildHeaderCellRight('xxxx', context),
                        //     ),
                        //   ],
                        // ),
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'IOS Version 2',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['mainDeviceiOSVersion'] ?? 'N/A',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'IOS Version 3',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['backupDeviceiOSVersion'] ?? 'N/A',
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
                        0: const pw.FlexColumnWidth(1),
                        1: const pw.FlexColumnWidth(4),
                      },
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft('Charger No', context),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['charger'] ?? 'N/A',
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
                      columnWidths: {0: const pw.FlexColumnWidth(1)},
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 25.0,
                              child: buildHeaderCell('EFB Software', context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    pw.Table(
                      tableWidth: pw.TableWidth.min,
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: const pw.FlexColumnWidth(2),
                        1: const pw.FlexColumnWidth(3),
                        2: const pw.FlexColumnWidth(2),
                        3: const pw.FlexColumnWidth(3),
                      },
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'FlySmart Version 2',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['mainDeviceFlySmart'] ?? 'N/A',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'FlySmart Version 3',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['backupDeviceFlySmart'] ?? 'N/A',
                                context,
                              ),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Lido mPilot Version 2',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['mainDeviceLidoVersion'] ?? 'N/A',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Lido mPilot Version 3',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['backupDeviceLidoVersion'] ?? 'N/A',
                                context,
                              ),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Docunet Version 2',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['mainDeviceDocuVersion'] ?? 'N/A',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Docunet Version 3',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['backupDeviceDocuVersion'] ?? 'N/A',
                                context,
                              ),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Device Condition 2',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['mainDeviceCategory'] ?? 'N/A',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Device Condition 3',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['backupDeviceCategory'] ?? 'N/A',
                                context,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ] else ...[
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Align(
                          child: pw.Text(
                            '1st Device',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.Align(
                          child: pw.Text(
                            detail['received_at'] == null
                                ? _formatTimestamp(detail['handover_date'])
                                : _formatTimestamp(detail['received_at']),
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.Table(
                      tableWidth: pw.TableWidth.min,
                      border: pw.TableBorder.all(),
                      columnWidths: {0: const pw.FlexColumnWidth(1)},
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 25.0,
                              child: buildHeaderCell('EFB Device', context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    pw.Table(
                      tableWidth: pw.TableWidth.min,
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: const pw.FlexColumnWidth(2),
                        1: const pw.FlexColumnWidth(3),
                      },
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Device No 1',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['deviceno'],
                                context,
                              ),
                            ),
                          ],
                        ),
                        // pw.TableRow(
                        //   children: [
                        //     pw.Container(
                        //       height: 20.0,
                        //       child: _buildHeaderCellLeft('Charger No', context),
                        //     ),
                        //     pw.Container(
                        //       height: 20.0,
                        //       child: _buildHeaderCellRight('xxxx', context),
                        //     ),
                        //   ],
                        // ),
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'IOS Version',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['ios_version'],
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
                      columnWidths: {0: const pw.FlexColumnWidth(1)},
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 25.0,
                              child: buildHeaderCell('EFB Software', context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    pw.Table(
                      tableWidth: pw.TableWidth.min,
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: const pw.FlexColumnWidth(2),
                        1: const pw.FlexColumnWidth(3),
                      },
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'FlySmart Version',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['fly_smart'],
                                context,
                              ),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Lido mPilot Version',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['lido_version'],
                                context,
                              ),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Docunet Version',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['doc_version'],
                                context,
                              ),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Device Condition',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['category'],
                                context,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                  pw.Table(
                    tableWidth: pw.TableWidth.min,
                    border: pw.TableBorder.all(),
                    columnWidths: {0: const pw.FlexColumnWidth(1)},
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Container(
                            height: 35.0,
                            padding: const pw.EdgeInsets.all(5.0),
                            child: pw.Text(
                              'It is confirmed that all IAA Operation Manual in this EFB are updated and EFB device in good condition',
                              style: pw.TextStyle(
                                fontStyle: pw.FontStyle.italic,
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  if (detail['status'] == 'handover') ...[
                    pw.SizedBox(height: 10.0),
                    pw.Table(
                      tableWidth: pw.TableWidth.min,
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: const pw.FlexColumnWidth(4),
                        1: const pw.FlexColumnWidth(4),
                        2: const pw.FlexColumnWidth(4),
                      },
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCell(
                                'Handover Details',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCell('Name', context),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCell('ID', context),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                'Handover From',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['request_user_name'],
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellRight(
                                detail['request_user'],
                                context,
                              ),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                'Handover To',
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                detail['handover_user_name'],
                                context,
                              ),
                            ),
                            pw.Container(
                              height: 20.0,
                              child: buildHeaderCellLeft(
                                detail['handover_to'],
                                context,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 30),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 5,
                          child: pw.Column(
                            children: [
                              pw.Text('1st Crew on Duty'),
                              pw.SizedBox(height: 5.0),
                              pw.Container(
                                child: requestUserSignatureWidget,
                                width: 150,
                                height: 90,
                              ),
                              pw.SizedBox(height: 5.0),
                              pw.Text(
                                detail['request_user_name'],
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          flex: 5,
                          child: pw.Column(
                            children: [
                              pw.Text('2nd Crew on Duty'),
                              pw.SizedBox(height: 5.0),
                              pw.Container(
                                child: otherCrewSignatureWidget,
                                width: 150,
                                height: 90,
                              ),
                              pw.SizedBox(height: 5.0),
                              pw.Text(
                                detail['handover_user_name'],
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 30),
                    pw.Column(children: [footer]),
                  ],

                  if (detail['status'] == 'returned') ...[
                    pw.SizedBox(height: 30),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 5,
                          child: pw.Column(children: [pw.Text('Accepted By')]),
                        ),
                        pw.Expanded(
                          flex: 5,
                          child: pw.Column(children: [pw.Text('Requested By')]),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 5,
                          child: pw.Column(
                            children: [
                              pw.SizedBox(height: 5.0),
                              pw.Container(
                                child: occSignatureWidget,
                                width: 150,
                                height: 90,
                              ),
                              pw.SizedBox(height: 5.0),
                              pw.Text(
                                detail['received_user_name'],
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 2.0),
                              pw.Text(
                                'OCC',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          flex: 5,
                          child: pw.Column(
                            children: [
                              pw.SizedBox(height: 5.0),
                              pw.Container(
                                child: requestUserSignatureWidget,
                                width: 150,
                                height: 90,
                              ),
                              pw.SizedBox(height: 5.0),
                              pw.Text(
                                detail['request_user_name'],
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 2.0),
                              pw.Text(
                                detail['request_user_rank'],
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 120),
                    pw.Column(children: [footer]),
                  ],
                ],
              );
            },
          ),
        );

        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/handover-log.pdf';
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
