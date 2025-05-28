// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:airmaster/model/devices/device.dart';
import 'package:airmaster/screens/home/efb/devices/controller/efb_device_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:airmaster/widgets/input_decoration.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stroke_text/stroke_text.dart';

class EFB_Device extends GetView<EFB_Device_Controller> {
  const EFB_Device({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
        child: Column(
          children: [
            TextField(
              autofocus: false,
              controller: controller.textSearchField,
              decoration: CustomInputDecoration.customInputDecorationWithIcon(
                labelText: 'Search by ID',
                icon: Icon(Icons.search, color: ColorConstants.blackColor),
              ),
              onChanged: (value) {
                log('Search query: $value');
                controller.searchDevice(value);
              },
            ),
            SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.foundedDevices.length,
                  itemBuilder: (context, index) {
                    final device = controller.foundedDevices[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: ColorConstants.blackColor),
                        borderRadius: BorderRadius.circular(
                          SizeConstant.BORDER_RADIUS,
                        ),
                      ),
                      color: ColorConstants.backgroundColor,
                      child: ListTile(
                        onTap: () {
                          log('Tapped on device: ${device.deviceNo}');
                          showDeviceDialog(context, device.deviceNo);
                        },
                        leading: Icon(Icons.device_hub),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                        ),
                        title: Text(
                          device.deviceNo,
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          device.iosVersion,
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE_HINT,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDeviceDialog(BuildContext context, String deviceNo) async {
    Device device = controller.getDeviceById(deviceNo);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: ColorConstants.backgroundColor,
          shadowColor: ColorConstants.shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
          ),
          child: Padding(
            padding: EdgeInsets.all(SizeConstant.PADDING),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Device Details',
                  style: GoogleFonts.notoSans(
                    color: ColorConstants.textPrimary,
                    fontSize: SizeConstant.TEXT_SIZE_MAX,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_DOUBLE),
                buildPropertyRow('Device Number', device.deviceNo),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                buildPropertyRow('iOS Version', device.iosVersion),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                buildPropertyRow('Fly Smart Version', device.flySmart),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                buildPropertyRow('Lido mPilot Version', device.lidoVersion),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                buildPropertyRow('Hub', device.hub),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                buildPropertyRow(
                  'Status',
                  device.status ? 'Available' : 'Unavailable',
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                CustomDivider(divider: 'QR Code Device'),
                generateWallpaper(deviceNo),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      captureAndDownloadWallpaper(context, deviceNo);
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        ColorConstants.primaryColor,
                      ),
                    ),
                    child: Obx(() {
                      return controller.isLoading.value
                          ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              ColorConstants.textSecondary,
                            ),
                          )
                          : Text(
                            'Download Wallpaper',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textSecondary,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPropertyRow(String propertyName, String propertyValue) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '$propertyName : ',
            style: GoogleFonts.notoSans(
              color: ColorConstants.textPrimary,
              fontSize: SizeConstant.TEXT_SIZE,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Expanded(
          flex: 0,
          child: Text(
            propertyValue,
            style: GoogleFonts.notoSans(
              color: ColorConstants.textPrimary,
              fontSize: SizeConstant.TEXT_SIZE,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget generateWallpaper(String deviceNo) {
    return Screenshot(
      controller: controller.screenshotController,
      child: RepaintBoundary(
        key: controller.captureKey,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(image: AssetImage('assets/images/efb_qr_wallpaper.png')),
            Column(
              children: [
                QrImageView(
                  data: deviceNo,
                  version: QrVersions.auto,
                  size: 125.0,
                  foregroundColor: ColorConstants.blackColor,
                ),
                StrokeText(
                  textAlign: TextAlign.center,
                  text: 'EFB - IPAD',
                  textStyle: GoogleFonts.lilitaOne(
                    letterSpacing: 1.0,
                    wordSpacing: 1.0,
                    color: ColorConstants.creamColor,
                    fontSize: SizeConstant.TEXT_SIZE_MAX,
                    fontWeight: FontWeight.bold,
                  ),
                  strokeColor: ColorConstants.blackColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void captureAndDownloadWallpaper(
    BuildContext context,
    String deviceNo,
  ) async {
    controller.isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 300));

    controller.screenshotController
        .capture(
          delay: Durations.long2,
          pixelRatio: MediaQuery.of(Get.context!).devicePixelRatio,
        )
        .then((capturedImage) async {
          if (capturedImage != null) {
            final buffer = capturedImage.buffer.asUint8List();
            log('Captured image size: ${buffer.length} bytes');

            if (buffer.isNotEmpty) {
              final result = await ImageGallerySaverPlus.saveImage(
                buffer,
                quality: 100,
                name: 'EFB_IAA_$deviceNo',
              );

              log('Image saved to gallery: $result');
              Get.snackbar(
                'Success',
                'Wallpaper downloaded successfully!',
                backgroundColor: ColorConstants.whiteColor,
                titleText: Text(
                  'Success',
                  style: GoogleFonts.notoSans(
                    color: ColorConstants.successColor,
                    fontSize: SizeConstant.TEXT_SIZE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                messageText: Text(
                  'Wallpaper downloaded successfully!',
                  style: GoogleFonts.notoSans(
                    color: ColorConstants.textPrimary,
                    fontSize: SizeConstant.TEXT_SIZE,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                snackPosition: SnackPosition.TOP,
              );
            }
          }
        })
        .whenComplete(() {
          controller.isLoading.value = false;
          Future.delayed(Duration(milliseconds: 100), () {
            Navigator.of(context).pop();
          });
        });
  }
}
