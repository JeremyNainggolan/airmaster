import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/screens/home/efb/history/view/history-detail/view/handover-log-format/controller/handover_log_format_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/build_row_text_field.dart';
import 'package:airmaster/widgets/shimmer_box.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Handover_Log_Format_View extends GetView<Handover_Log_Format_Controller> {
  const Handover_Log_Format_View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "EFB | PDF Format",
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
          return Padding(
            padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: 200, height: 24),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.tertiaryColor,
                    borderRadius: BorderRadius.circular(
                      SizeConstant.BORDER_RADIUS,
                    ),
                    border: Border.all(color: ColorConstants.blackColor),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerBox(width: 100, height: 18),
                      SizedBox(height: 8),
                      ShimmerBox(width: double.infinity, height: 16),
                      SizedBox(height: 8),
                      ShimmerBox(width: double.infinity, height: 16),
                      SizedBox(height: 16),
                      ShimmerBox(width: 100, height: 18),
                      SizedBox(height: 8),
                      ShimmerBox(width: double.infinity, height: 16),
                      SizedBox(height: 8),
                      ShimmerBox(width: double.infinity, height: 16),
                      SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ShimmerBox(width: 100, height: 36),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.format.isEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: GoogleFonts.notoSans(
                color: ColorConstants.textPrimary,
                fontSize: SizeConstant.TEXT_SIZE_HINT,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Handover PDF Format',
                    style: GoogleFonts.notoSans(
                      fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.tertiaryColor,
                  borderRadius: BorderRadius.circular(
                    SizeConstant.BORDER_RADIUS,
                  ),
                  border: Border.all(color: ColorConstants.blackColor),
                ),
                width: double.infinity,
                padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Header',
                      style: GoogleFonts.notoSans(
                        fontSize: SizeConstant.TEXT_SIZE,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    BuildRowWithTextField(
                      label: 'Rec No.',
                      controller: controller.recNumberController,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Date',
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textPrimary,
                                    fontSize: SizeConstant.TEXT_SIZE_HINT,
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                ":",
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textPrimary,
                                  fontSize: SizeConstant.TEXT_SIZE_HINT,
                                ),
                              ),
                            ),

                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: controller.dateController,
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textPrimary,
                                    fontSize: SizeConstant.TEXT_SIZE,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 12.0,
                                    ),
                                  ),
                                  onTap: () async {
                                    await controller.selectDate();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                    Text(
                      'Footer',
                      style: GoogleFonts.notoSans(
                        fontSize: SizeConstant.TEXT_SIZE,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    BuildRowWithTextField(
                      label: 'Footer Left',
                      controller: controller.footerLeftController,
                    ),
                    BuildRowWithTextField(
                      label: 'Footer Right',
                      controller: controller.footerRightController,
                    ),
                    SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.primaryColor,
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConstant.VERTICAL_PADDING,
                              horizontal: SizeConstant.HORIZONTAL_PADDING * 4,
                            ),
                          ),
                          onPressed: () async {
                            final isConfirmed = await ShowAlert.showConfirmAlert(
                              Get.context!,
                              'Confirm',
                              'Are you sure you want to update the PDF format?',
                            );

                            if (isConfirmed == true) {
                              ShowAlert.showLoadingAlert(
                                Get.context!,
                                'Updating PDF format...',
                              );

                              final isSuccess = await controller.saveFormat();

                              if (isSuccess) {
                                QuickAlert.show(
                                  barrierDismissible: false,
                                  context: Get.context!,
                                  type: QuickAlertType.success,
                                  title: 'Success',
                                  text: 'PDF format updated successfully.',
                                  confirmBtnTextStyle: GoogleFonts.notoSans(
                                    color: ColorConstants.textSecondary,
                                    fontSize: SizeConstant.TEXT_SIZE_HINT,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  onConfirmBtnTap: () async {
                                    Get.back();
                                    Get.back();
                                  },
                                );
                                controller.loadFormat();
                              } else {
                                ShowAlert.showErrorAlert(
                                  Get.context!,
                                  'Error',
                                  'Failed to update PDF format. Please try again.',
                                );
                              }
                            }
                          },
                          child: Text(
                            'Update',
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.textSecondary,
                              fontSize: SizeConstant.TEXT_SIZE_HINT,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
