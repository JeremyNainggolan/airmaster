import 'dart:ui';

import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/return-occ/controller/occ_return_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class Occ_Return_View extends GetView<Occ_Return_Controller> {
  const Occ_Return_View({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final confirmed = await ShowAlert.showBackAlert(context);

        if (confirmed == true) {
          Get.back();
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          leading: IconButton(
            onPressed: () async {
              final confirmed = await ShowAlert.showBackAlert(context);

              if (confirmed == true) {
                Get.back();
              }
            },
            icon: Icon(Icons.arrow_back, color: ColorConstants.whiteColor),
          ),
          title: Text(
            'EFB | OCC Return',
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: SizeConstant.SUB_HEADING_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.whiteColor,
                    borderRadius: BorderRadius.circular(
                      SizeConstant.BORDER_RADIUS,
                    ),
                    border: Border.all(color: ColorConstants.blackColor),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Note:',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        Text(
                          'You must be in one place with the OCC to confirm the return. If you are in a different place, whatever the OCC contains, you automatically agree with its statement.',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.primaryColor,
                            fontSize: SizeConstant.TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),
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
                          'Remarks',
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
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        TextField(
                          controller: controller.remark,
                          decoration:
                              CustomInputDecoration.customInputDecoration(
                                labelText: 'Fill if returned via FO',
                              ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          onChanged: ((value) {
                            controller.remark.text = value;
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT_2),
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
                                      await controller
                                          .signatureKey
                                          .currentState!
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
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (controller.signatureImg == null) {
                                ShowAlert.showErrorAlertWithoutLoading(
                                  Get.context!,
                                  'Signature Required',
                                  'Please provide your signature before proceeding.',
                                );
                                return;
                              }

                              final confirm = await ShowAlert.showConfirmAlert(
                                Get.context!,
                                'Confirm Handover',
                                'Are you sure you want to hand over the device to the next FO?',
                              );

                              if (confirm == true) {
                                QuickAlert.show(
                                  barrierDismissible: false,
                                  context: Get.context!,
                                  type: QuickAlertType.loading,
                                  text: 'Handing over...',
                                );

                                final success = await controller.returnOCC();

                                if (Get.isDialogOpen ?? false) Get.back();

                                if (success) {
                                  await ShowAlert.showFetchSuccess(
                                    Get.context!,
                                    'Success',
                                    'Device handover completed successfully.',
                                  );
                                  Get.back();
                                  Get.back(result: true);
                                } else {
                                  await ShowAlert.showErrorAlert(
                                    Get.context!,
                                    'Error',
                                    'Failed to complete the handover. Please try again.',
                                  );
                                }
                              }
                            },
                            child: Text(
                              'Return',
                              style: GoogleFonts.notoSans(
                                color: ColorConstants.textSecondary,
                                fontSize: SizeConstant.TEXT_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
