import 'dart:ui';

import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/screens/home/efb/home/view/accept-handover/controller/accept_handover_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/build_row.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:airmaster/helpers/input_decoration.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class Accept_Handover_View extends GetView<Accept_Handover_Controller> {
  const Accept_Handover_View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () async {
            Get.back();
          },
        ),
        title: Text(
          "EFB | Pilot Handover",
          style: GoogleFonts.notoSans(
            color: ColorConstants.textSecondary,
            fontSize: SizeConstant.SUB_HEADING_SIZE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: LoadingAnimationWidget.hexagonDots(
              color: ColorConstants.activeColor,
              size: 48,
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.tertiaryColor,
                  borderRadius: BorderRadius.circular(
                    SizeConstant.BORDER_RADIUS,
                  ),
                  border: Border.all(color: ColorConstants.successColor),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Handover From",
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BuildRow(
                        label: "ID Number",
                        value: controller.detail['request_user'],
                      ),
                      BuildRow(
                        label: "Name",
                        value: controller.detail['request_user_name'],
                      ),
                      BuildRow(
                        label: "Rank",
                        value: controller.detail['request_user_rank'],
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      Text(
                        "Handover To",
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BuildRow(
                        label: "ID Number",
                        value: controller.detail['handover_to'],
                      ),
                      BuildRow(
                        label: "Name",
                        value: controller.detail['handover_user_name'],
                      ),
                      BuildRow(
                        label: "Rank",
                        value: controller.detail['handover_user_rank'],
                      ),

                      CustomDivider(divider: 'Device Details'),
                      BuildRow(
                        label: "Device No",
                        value: controller.detail['deviceno'],
                      ),
                      BuildRow(
                        label: "iOS Version",
                        value: controller.detail['ios_version'],
                      ),
                      BuildRow(
                        label: "Fly Smart Version",
                        value: controller.detail['fly_smart'],
                      ),
                      BuildRow(
                        label: "Lido mPilot Version",
                        value: controller.detail['lido_version'],
                      ),
                      BuildRow(label: "Hub", value: controller.detail['hub']),
                      BuildRow(
                        label: "Condition",
                        value: controller.detail['category'],
                      ),
                      CustomDivider(divider: 'Device Condition'),
                      Text(
                        'Here you can explain the condition of the device you received',
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: SizeConstant.TEXT_SIZE_HINT,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text(
                              "Category",
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textPrimary,
                                fontSize: SizeConstant.TEXT_SIZE_HINT,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          DropdownButton<String>(
                            value: controller.category.value,
                            underline: Container(),
                            dropdownColor: ColorConstants.backgroundColor,
                            onChanged: (value) {
                              controller.category.value = value!;
                            },
                            borderRadius: BorderRadius.circular(
                              SizeConstant.BORDER_RADIUS,
                            ),
                            items:
                                <String>[
                                  'Good',
                                  'Good With Remarks',
                                  'Unserviceable',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.textPrimary,
                                        fontSize: SizeConstant.TEXT_SIZE_HINT,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
                      TextField(
                        onTap: () => controller.categoryRemark.value = '',
                        onChanged: (value) {
                          controller.categoryRemark.value = value;
                        },
                        decoration: CustomInputDecoration.customInputDecoration(
                          labelText: 'Remarks',
                        ),
                      ),
                      CustomDivider(divider: 'Report Any Damage'),
                      Text(
                        'Here you can explain the damage of the device you received',
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: SizeConstant.TEXT_SIZE_HINT,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),
                      TextField(
                        onTap: () => controller.damageRemark.value = '',
                        onChanged: (value) {
                          controller.damageRemark.value = value;
                        },
                        decoration: CustomInputDecoration.customInputDecoration(
                          labelText: 'Report Damage',
                        ),
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await controller.getImageFromCamera();
                          },
                          label: Text(
                            'Take a photo of the damage',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.whiteColor,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: Icon(
                            Icons.camera,
                            color: ColorConstants.whiteColor,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.tertiaryColor,
                  borderRadius: BorderRadius.circular(
                    SizeConstant.BORDER_RADIUS,
                  ),
                  border: Border.all(
                    color: ColorConstants.blackColor,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Signature',
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textTertiary,
                          fontSize: SizeConstant.TEXT_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: ColorConstants.dividerColor,
                        thickness: SizeConstant.DIVIDER_THICKNESS_LOW,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                SizeConstant.BORDER_RADIUS,
                              ),
                            ),
                            child: SfSignaturePad(
                              key: controller.signatureKey,
                              backgroundColor: Colors.white,
                              onDrawEnd: () async {
                                final imageData =
                                    await controller.signatureKey.currentState!
                                        .toImage();
                                final byteData = await imageData.toByteData(
                                  format: ImageByteFormat.png,
                                );

                                if (byteData != null) {
                                  controller.signatureImg =
                                      byteData.buffer.asUint8List();
                                }
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(
                                Icons.delete_outline_outlined,
                                size: 32,
                                color: ColorConstants.primaryColor,
                              ),
                              onPressed: () {
                                controller.signatureKey.currentState?.clear();

                                controller.signatureImg = null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(SizeConstant.PADDING_MIN),
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              'assets/images/airasia_logo_circle.png',
                              width: MediaQuery.of(context).size.width * 0.1,
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
        );
      }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConstant.VERTICAL_PADDING,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.successColor,
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () async {
                if (controller.signatureImg == null) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    title: 'Warning',
                    text: 'Please provide your signature.',
                    confirmBtnText: 'Okay',
                    confirmBtnTextStyle: GoogleFonts.notoSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                  return;
                }

                final isConfirmed = await ShowAlert.showConfirmAlert(
                  Get.context!,
                  'Confirm Handover',
                  'Are you sure you want to confirm the handover?',
                );

                if (isConfirmed == true) {
                  ShowAlert.showLoadingAlert(
                    Get.context!,
                    'Confirming handover...',
                  );

                  final isSuccess = await controller.acceptHandover();

                  if (isSuccess) {
                    ShowAlert.showSuccessAlert(
                      Get.context!,
                      'Success',
                      'Handover confirmed successfully.',
                    );
                  } else {
                    ShowAlert.showErrorAlert(
                      Get.context!,
                      'Error',
                      'Failed to confirm handover. Please try again.',
                    );
                  }
                }
              },
              child: Text(
                'Confirm Handover',
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
