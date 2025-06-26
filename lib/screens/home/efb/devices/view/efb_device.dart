// ignore_for_file: camel_case_types

import 'package:airmaster/model/devices/device.dart';
import 'package:airmaster/screens/home/efb/devices/controller/efb_device_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:airmaster/helpers/input_decoration.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stroke_text/stroke_text.dart';

class EFB_Device extends GetView<EFB_Device_Controller> {
  const EFB_Device({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Obx(
        () => Padding(
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
                  controller.searchDevice(value);
                },
              ),
              SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
              Expanded(
                child:
                    controller.isLoading.value
                        ? Center(
                          child: LoadingAnimationWidget.hexagonDots(
                            color: ColorConstants.activeColor,
                            size: 48,
                          ),
                        )
                        : RefreshIndicator(
                          onRefresh: controller.refreshData,
                          child:
                              controller.foundedDevices.isEmpty
                                  ? ListView(
                                    children: [
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.device_hub,
                                              size: 40,
                                              color:
                                                  ColorConstants.primaryColor,
                                            ),
                                            Text(
                                              'No Device Found',
                                              style: GoogleFonts.notoSans(
                                                color:
                                                    ColorConstants.textPrimary,
                                                fontSize:
                                                    SizeConstant.TEXT_SIZE_HINT,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                  : ListView.builder(
                                    itemCount: controller.foundedDevices.length,
                                    itemBuilder: (context, index) {
                                      final device =
                                          controller.foundedDevices[index];
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: ColorConstants.blackColor,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            SizeConstant.BORDER_RADIUS,
                                          ),
                                        ),
                                        color: ColorConstants.backgroundColor,
                                        child: ListTile(
                                          onTap: () {
                                            showDeviceDialog(
                                              context,
                                              device.deviceNo,
                                            );
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
                                              fontSize:
                                                  SizeConstant.TEXT_SIZE_HINT,
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
                buildInfoRow('Device Number', device.deviceNo),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                buildInfoRow('iOS Version', device.iosVersion),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                buildInfoRow('Fly Smart Version', device.flySmart),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                buildInfoRow('Lido mPilot Version', device.lidoVersion),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                buildInfoRow('Hub', device.hub),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                buildInfoRow(
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
                    onPressed: () async {
                      QuickAlert.show(
                        context: Get.context!,
                        type: QuickAlertType.loading,
                        text: 'Downloading...',
                      );

                      var result = await captureAndDownloadWallpaper(deviceNo);

                      if (Get.isDialogOpen ?? false) {
                        Get.back();
                      }

                      if (result) {
                        QuickAlert.show(
                          barrierDismissible: false,
                          context: Get.context!,
                          type: QuickAlertType.success,
                          title: 'Success!',
                          text: 'Wallpaper downloaded successfully.',
                          confirmBtnTextStyle: GoogleFonts.notoSans(
                            color: ColorConstants.textSecondary,
                            fontSize: SizeConstant.TEXT_SIZE_HINT,
                            fontWeight: FontWeight.normal,
                          ),
                          onConfirmBtnTap: () async {
                            Get.back();
                            Get.back();
                            Get.back();
                          },
                        );
                      } else {
                        QuickAlert.show(
                          context: Get.context!,
                          type: QuickAlertType.error,
                          title: 'Failed',
                          text:
                              'Failed to download wallpaper. Please try again.',
                          confirmBtnTextStyle: GoogleFonts.notoSans(
                            color: ColorConstants.textSecondary,
                            fontSize: SizeConstant.TEXT_SIZE_HINT,
                            fontWeight: FontWeight.normal,
                          ),
                          onConfirmBtnTap: () async {
                            Get.back();
                            Get.back();
                            Get.back();
                          },
                        );
                      }
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        ColorConstants.primaryColor,
                      ),
                    ),
                    child: Text(
                      'Download Wallpaper',
                      style: GoogleFonts.notoSans(
                        color: ColorConstants.textSecondary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 150, child: buildTextKey(label)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              ":",
              style: GoogleFonts.notoSans(color: ColorConstants.textPrimary),
            ),
          ),
          Expanded(child: buildTextValue(value.isNotEmpty ? value : "-")),
        ],
      ),
    );
  }

  Widget buildTextKey(String text) {
    return Text(
      text,
      style: GoogleFonts.notoSans(
        color: ColorConstants.textPrimary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget buildTextValue(String text) {
    return Text(
      text,
      textAlign: TextAlign.end,
      style: GoogleFonts.notoSans(
        color: ColorConstants.textPrimary,
        fontSize: SizeConstant.TEXT_SIZE,
        fontWeight: FontWeight.bold,
      ),
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

  Future<bool> captureAndDownloadWallpaper(String deviceNo) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final capturedImage = await controller.screenshotController.capture(
        delay: Durations.long2,
        pixelRatio: MediaQuery.of(Get.context!).devicePixelRatio,
      );

      if (capturedImage != null) {
        final buffer = capturedImage.buffer.asUint8List();

        if (buffer.isNotEmpty) {
          final _ = await ImageGallerySaverPlus.saveImage(
            buffer,
            quality: 100,
            name: 'EFB_IAA_$deviceNo',
          );

          Future.delayed(const Duration(seconds: 2));
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
