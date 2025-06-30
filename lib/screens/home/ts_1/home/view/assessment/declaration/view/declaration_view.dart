import 'dart:ui';

import 'package:airmaster/helpers/input_decoration.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/declaration/controller/declaration_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:airmaster/helpers/show_alert.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class Declaration_View extends GetView<Declaration_Controller> {
  const Declaration_View({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final shouldPop = await ShowAlert.showBackAlert(Get.context!);

          if (shouldPop == true) {
            Get.back();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
            onPressed: () async {
              final shouldPop = await ShowAlert.showBackAlert(Get.context!);

              if (shouldPop == true) {
                Get.back();
              }
            },
          ),
          title: Text(
            "Assessment | Declaration",
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: SizeConstant.SUB_HEADING_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: ColorConstants.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstant.SCREEN_PADDING,
          ),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            CustomDivider(divider: 'First Crew'),
                            DropdownButtonFormField<String>(
                              value:
                                  controller.firstCrewDeclaration.value.isEmpty
                                      ? null
                                      : controller.firstCrewDeclaration.value,
                              decoration:
                                  CustomInputDecoration.customInputDecoration(
                                    labelText: 'For Training',
                                  ),
                              dropdownColor: ColorConstants.backgroundColor,
                              items:
                                  controller.declarationList
                                      .map(
                                        (perf) => DropdownMenuItem<String>(
                                          value: perf,
                                          child: Text(
                                            perf,
                                            style: GoogleFonts.notoSans(
                                              color: ColorConstants.textPrimary,
                                              fontSize:
                                                  SizeConstant.TEXT_SIZE_HINT,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                controller.firstCrewDeclaration.value = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
                      Expanded(
                        child: Column(
                          children: [
                            CustomDivider(divider: 'Second Crew'),
                            DropdownButtonFormField<String>(
                              value:
                                  controller.secondCrewDeclaration.value.isEmpty
                                      ? null
                                      : controller.secondCrewDeclaration.value,
                              decoration:
                                  CustomInputDecoration.customInputDecoration(
                                    labelText: 'For Training',
                                  ),
                              dropdownColor: ColorConstants.backgroundColor,
                              items:
                                  controller.declarationList
                                      .map(
                                        (perf) => DropdownMenuItem<String>(
                                          value: perf,
                                          child: Text(
                                            perf,
                                            style: GoogleFonts.notoSans(
                                              color: ColorConstants.textPrimary,
                                              fontSize:
                                                  SizeConstant.TEXT_SIZE_HINT,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                controller.secondCrewDeclaration.value = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomDivider(divider: 'Signature Pad'),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
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
                                    controller.signatureKey.currentState
                                        ?.clear();

                                    controller.signatureImg = null;
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(
                                  SizeConstant.PADDING_MIN,
                                ),
                                alignment: Alignment.topLeft,
                                child: Image.asset(
                                  'assets/images/airasia_logo_circle.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
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
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(SizeConstant.PADDING),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () async {
              Get.until((route) => route.settings.name == AppRoutes.TS1_MAIN);
            },
            child: Text(
              'Submit',
              style: GoogleFonts.notoSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
