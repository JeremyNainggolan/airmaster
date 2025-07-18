import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/efb/history/view/history-detail/controller/history_detail_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:airmaster/widgets/build_row.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class History_Detail_View extends GetView<History_Detail_Controller> {
  const History_Detail_View({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.rank.value == 'OCC') {
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
              "EFB | History Detail",
              style: GoogleFonts.notoSans(
                color: ColorConstants.textSecondary,
                fontSize: SizeConstant.SUB_HEADING_SIZE,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: ColorConstants.backgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
              child: Container(
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
                        "Device Usage Information",
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: SizeConstant.SUB_HEADING_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      controller.detail['handover_to'] != null
                          ? Text(
                            "Handover to: ${controller.detail['handover_to']}",
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.primaryColor,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          : SizedBox(),
                      BuildRow(
                        label: "ID",
                        value: controller.detail['request_user'],
                      ),
                      BuildRow(
                        label: "Name",
                        value: controller.detail['request_user_name'],
                      ),
                      BuildRow(
                        label: "Rank",
                        value:
                            controller.detail['request_user_rank'].toString(),
                      ),
                      BuildRow(
                        label: "Request Date",
                        value: DateFormatter.convertDateTimeDisplay(
                          controller.detail['request_date'].toString(),
                          'dd MMMM yyyy',
                        ),
                      ),
                      controller.detail['received_at'] == null
                          ? BuildRow(label: "Handover Date", value: 'Biawak')
                          : BuildRow(
                            label: "Return Date",
                            value: DateFormatter.convertDateTimeDisplay(
                              controller.detail['received_at'].toString(),
                              'dd MMMM yyyy',
                            ),
                          ),
                      CustomDivider(divider: 'Device Information'),
                      if (controller.detail['isFoRequest'] == true) ...[
                        BuildRow(
                          label: "Device No",
                          value: controller.detail['mainDeviceNo'],
                        ),
                        BuildRow(
                          label: "iOS Version",
                          value: controller.detail['mainDeviceiOSVersion'],
                        ),
                        BuildRow(
                          label: "Fly Smart Version",
                          value: controller.detail['mainDeviceFlySmart'],
                        ),
                        BuildRow(
                          label: "Docunet Version",
                          value: controller.detail['mainDeviceDocuVersion'],
                        ),
                        BuildRow(
                          label: "Lido mPilot Version",
                          value: controller.detail['mainDeviceLidoVersion'],
                        ),
                        BuildRow(
                          label: "Hub",
                          value: controller.detail['mainDeviceHub'],
                        ),
                        BuildRow(
                          label: "Category",
                          value: controller.detail['mainDeviceCategory'],
                        ),
                        BuildRow(
                          label: "Remark",
                          value: controller.detail['mainDeviceRemark'] ?? '-',
                        ),
                        CustomDivider(divider: 'Backup Device Information'),
                        BuildRow(
                          label: "Device No",
                          value: controller.detail['backupDeviceNo'],
                        ),
                        BuildRow(
                          label: "iOS Version",
                          value: controller.detail['backupDeviceiOSVersion'],
                        ),
                        BuildRow(
                          label: "Fly Smart Version",
                          value: controller.detail['backupDeviceFlySmart'],
                        ),
                        BuildRow(
                          label: "Docunet Version",
                          value: controller.detail['backupDeviceDocuVersion'],
                        ),
                        BuildRow(
                          label: "Lido mPilot Version",
                          value: controller.detail['backupDeviceLidoVersion'],
                        ),
                        BuildRow(
                          label: "Hub",
                          value: controller.detail['backupDeviceHub'],
                        ),
                        BuildRow(
                          label: "Category",
                          value: controller.detail['backupDeviceCategory'],
                        ),
                        BuildRow(
                          label: "Remark",
                          value: controller.detail['backupDeviceRemark'] ?? '-',
                        ),
                        CustomDivider(divider: 'Device Condition'),
                        Text(
                          'Main Device Condition',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BuildRow(
                          label: "Given Condition",
                          value: controller.detail['mainDeviceCategory'],
                        ),
                        BuildRow(
                          label: "Given Remark",
                          value: controller.detail['mainDeviceRemark'] ?? '-',
                        ),
                        Text(
                          'Backup Device Condition',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BuildRow(
                          label: "Given Condition",
                          value: controller.detail['backupDeviceCategory'],
                        ),
                        BuildRow(
                          label: "Given Remark",
                          value: controller.detail['backupDeviceRemark'] ?? '-',
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        controller.detail['receive_category'] != null
                            ? BuildRow(
                              label: "Received Condition",
                              value: controller.detail['receive_category'],
                            )
                            : BuildRow(label: "Received Condition", value: '-'),
                        controller.detail['receive_remark'] != null
                            ? BuildRow(
                              label: "Received Remark",
                              value: controller.detail['receive_remark'] ?? '-',
                            )
                            : BuildRow(label: "Received Remark", value: '-'),
                        CustomDivider(divider: 'Handling Information'),
                        BuildRow(
                          label: "Given By",
                          value: controller.detail['request_user_name'],
                        ),
                        controller.detail['received_user_name'] == null
                            ? BuildRow(
                              label: "Received By",
                              value: controller.detail['handover_user_name'],
                            )
                            : BuildRow(
                              label: "Received By",
                              value: controller.detail['received_user_name'],
                            ),
                      ] else ...[
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
                        CustomDivider(divider: 'Device Condition'),
                        BuildRow(
                          label: "Given Condition",
                          value: controller.detail['category'],
                        ),
                        BuildRow(
                          label: "Given Remark",
                          value: controller.detail['remark'] ?? '-',
                        ),
                        controller.detail['receive_category'] != null
                            ? BuildRow(
                              label: "Received Condition",
                              value: controller.detail['receive_category'],
                            )
                            : BuildRow(label: "Received Condition", value: '-'),
                        controller.detail['receive_remark'] != null
                            ? BuildRow(
                              label: "Received Remark",
                              value: controller.detail['receive_remark'] ?? '-',
                            )
                            : BuildRow(label: "Received Remark", value: '-'),
                        CustomDivider(divider: 'Handling Information'),
                        BuildRow(
                          label: "Given By",
                          value: controller.detail['request_user_name'],
                        ),
                        controller.detail['received_user_name'] == null
                            ? BuildRow(
                              label: "Received By",
                              value: controller.detail['handover_user_name'],
                            )
                            : BuildRow(
                              label: "Received By",
                              value: controller.detail['received_user_name'],
                            ),
                      ],
                      CustomDivider(divider: 'Additional Information'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                'Proof Back to Base',
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textPrimary,
                                  fontSize: SizeConstant.TEXT_SIZE_HINT,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConstant.VERTICAL_PADDING,
                              ),
                              child: Text(
                                ":",
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textPrimary,
                                ),
                              ),
                            ),
                            Expanded(
                              child:
                                  controller.detail['returned_device_picture'] !=
                                          null
                                      ? GestureDetector(
                                        onTap: () async {
                                          controller.getImage(
                                            controller
                                                .detail['returned_device_picture'],
                                          );

                                          Get.dialog(
                                            Center(
                                              child:
                                                  LoadingAnimationWidget.flickr(
                                                    leftDotColor:
                                                        ColorConstants
                                                            .primaryColor,
                                                    rightDotColor:
                                                        ColorConstants
                                                            .secondaryColor,
                                                    size: 45,
                                                  ),
                                            ),
                                            barrierDismissible: false,
                                          );

                                          await Future.delayed(
                                            const Duration(seconds: 2),
                                          );

                                          Get.back();

                                          showImageDialog();
                                        },
                                        child: Text(
                                          'Open Image',
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.notoSans(
                                            decorationColor:
                                                ColorConstants.primaryColor,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationThickness: 2,
                                            fontStyle: FontStyle.italic,
                                            color: ColorConstants.primaryColor,
                                            fontSize: SizeConstant.TEXT_SIZE,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                      : Text(
                                        'Not Available',
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.notoSans(
                                          decorationColor:
                                              ColorConstants.primaryColor,
                                          decorationThickness: 2,
                                          fontStyle: FontStyle.italic,
                                          color: ColorConstants.primaryColor,
                                          fontSize: SizeConstant.TEXT_SIZE,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConstant.VERTICAL_PADDING,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                'Feedback Form',
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textPrimary,
                                  fontSize: SizeConstant.TEXT_SIZE_HINT,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: Text(
                                ":",
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textPrimary,
                                ),
                              ),
                            ),
                            Expanded(
                              child:
                                  controller.detail['feedback']
                                      ? GestureDetector(
                                        onTap: () async {
                                          Get.toNamed(
                                            AppRoutes
                                                .EFB_HISTORY_DETAIL_FEEDBACK,
                                            arguments: {
                                              'request_id':
                                                  controller
                                                      .detail['_id']['\$oid'],
                                              'history': controller.detail,
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Open Feedback',
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.notoSans(
                                            decorationColor:
                                                ColorConstants.primaryColor,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationThickness: 2,
                                            fontStyle: FontStyle.italic,
                                            color: ColorConstants.primaryColor,
                                            fontSize: SizeConstant.TEXT_SIZE,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                      : Text(
                                        'Not Available',
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.notoSans(
                                          fontStyle: FontStyle.italic,
                                          color: ColorConstants.primaryColor,
                                          fontSize: SizeConstant.TEXT_SIZE,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
                    ShowAlert.showLoadingAlert(Get.context!, 'Please wait...');

                    await Future.delayed(Duration(seconds: 2));

                    final isSuccess = await controller.createDocument();

                    if (isSuccess == true) {
                      Get.back();
                    } else {
                      ShowAlert.showErrorAlert(
                        Get.context!,
                        'Failed to create document',
                        'Please try again later.',
                      );
                    }
                  },
                  child: Text(
                    'Open Handover Log',
                    style: GoogleFonts.notoSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(AppRoutes.EFB_HANDOVER_FORMAT_PDF);
            },
            child: Icon(
              Icons.edit_document,
              size: 38.0,
              color: ColorConstants.whiteColor,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      } else {
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
              "EFB | History Detail",
              style: GoogleFonts.notoSans(
                color: ColorConstants.textSecondary,
                fontSize: SizeConstant.SUB_HEADING_SIZE,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: ColorConstants.backgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
              child: Container(
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
                        "Device Usage Information",
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: SizeConstant.SUB_HEADING_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                      controller.detail['handover_to'] != null
                          ? Text(
                            "Handover to: ${controller.detail['handover_to']}",
                            style: GoogleFonts.notoSans(
                              color: ColorConstants.primaryColor,
                              fontSize: SizeConstant.TEXT_SIZE,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          : SizedBox(),
                      BuildRow(
                        label: "ID",
                        value: controller.detail['request_user'],
                      ),
                      BuildRow(
                        label: "Name",
                        value: controller.detail['request_user_name'],
                      ),
                      BuildRow(
                        label: "Rank",
                        value:
                            controller.detail['request_user_rank'].toString(),
                      ),
                      BuildRow(
                        label: "Request Date",
                        value: DateFormatter.convertDateTimeDisplay(
                          controller.detail['request_date'].toString(),
                          'dd MMMM yyyy',
                        ),
                      ),
                      controller.detail['received_at'] == null
                          ? BuildRow(label: "Handover Date", value: 'Biawak')
                          : BuildRow(
                            label: "Return Date",
                            value: DateFormatter.convertDateTimeDisplay(
                              controller.detail['received_at'].toString(),
                              'dd MMMM yyyy',
                            ),
                          ),
                      CustomDivider(divider: 'Device Information'),
                      if (controller.detail['isFoRequest'] == true) ...[
                        Text(
                          "Main Device Information",
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.SUB_HEADING_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        BuildRow(
                          label: "Device No",
                          value: controller.detail['mainDeviceNo'],
                        ),
                        BuildRow(
                          label: "iOS Version",
                          value: controller.detail['mainDeviceiOSVersion'],
                        ),
                        BuildRow(
                          label: "Fly Smart Version",
                          value: controller.detail['mainDeviceFlySmart'],
                        ),
                        BuildRow(
                          label: "Docunet Version",
                          value: controller.detail['mainDeviceDocuVersion'],
                        ),
                        BuildRow(
                          label: "Lido mPilot Version",
                          value: controller.detail['mainDeviceLidoVersion'],
                        ),
                        BuildRow(
                          label: "Hub",
                          value: controller.detail['mainDeviceHub'],
                        ),
                        BuildRow(
                          label: "Category",
                          value: controller.detail['mainDeviceCategory'],
                        ),
                        BuildRow(
                          label: "Remark",
                          value: controller.detail['mainDeviceRemark'] ?? '-',
                        ),
                        CustomDivider(divider: 'Backup Device Information'),
                        Text(
                          "Backup Device Information",
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.SUB_HEADING_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                        BuildRow(
                          label: "Device No",
                          value: controller.detail['backupDeviceNo'],
                        ),
                        BuildRow(
                          label: "iOS Version",
                          value: controller.detail['backupDeviceiOSVersion'],
                        ),
                        BuildRow(
                          label: "Fly Smart Version",
                          value: controller.detail['backupDeviceFlySmart'],
                        ),
                        BuildRow(
                          label: "Docunet Version",
                          value: controller.detail['backupDeviceDocuVersion'],
                        ),
                        BuildRow(
                          label: "Lido mPilot Version",
                          value: controller.detail['backupDeviceLidoVersion'],
                        ),
                        BuildRow(
                          label: "Hub",
                          value: controller.detail['backupDeviceHub'],
                        ),
                        BuildRow(
                          label: "Category",
                          value: controller.detail['backupDeviceCategory'],
                        ),
                        BuildRow(
                          label: "Remark",
                          value: controller.detail['backupDeviceRemark'] ?? '-',
                        ),
                        CustomDivider(divider: 'Device Condition'),
                        Text(
                          'Main Device Condition',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.SUB_HEADING_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BuildRow(
                          label: "Given Condition",
                          value: controller.detail['mainDeviceCategory'],
                        ),
                        BuildRow(
                          label: "Given Remark",
                          value: controller.detail['mainDeviceRemark'] ?? '-',
                        ),
                        Text(
                          'Backup Device Condition',
                          style: GoogleFonts.notoSans(
                            color: ColorConstants.textPrimary,
                            fontSize: SizeConstant.SUB_HEADING_SIZE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BuildRow(
                          label: "Given Condition",
                          value: controller.detail['backupDeviceCategory'],
                        ),
                        BuildRow(
                          label: "Given Remark",
                          value: controller.detail['backupDeviceRemark'] ?? '-',
                        ),
                        controller.detail['receive_category'] != null
                            ? BuildRow(
                              label: "Received Condition",
                              value: controller.detail['receive_category'],
                            )
                            : BuildRow(label: "Received Condition", value: '-'),
                        controller.detail['receive_remark'] != null
                            ? BuildRow(
                              label: "Received Remark",
                              value: controller.detail['receive_remark'] ?? '-',
                            )
                            : BuildRow(label: "Received Remark", value: '-'),
                        CustomDivider(divider: 'Handling Information'),
                        BuildRow(
                          label: "Given By",
                          value: controller.detail['request_user_name'],
                        ),
                        controller.detail['received_user_name'] == null
                            ? BuildRow(
                              label: "Received By",
                              value: controller.detail['handover_user_name'],
                            )
                            : BuildRow(
                              label: "Received By",
                              value: controller.detail['received_user_name'],
                            ),
                      ] else ...[
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
                        CustomDivider(divider: 'Device Condition'),
                        BuildRow(
                          label: "Given Condition",
                          value: controller.detail['category'],
                        ),
                        BuildRow(
                          label: "Given Remark",
                          value: controller.detail['remark'] ?? '-',
                        ),
                        controller.detail['receive_category'] != null
                            ? BuildRow(
                              label: "Received Condition",
                              value: controller.detail['receive_category'],
                            )
                            : BuildRow(label: "Received Condition", value: '-'),
                        controller.detail['receive_remark'] != null
                            ? BuildRow(
                              label: "Received Remark",
                              value: controller.detail['receive_remark'] ?? '-',
                            )
                            : BuildRow(label: "Received Remark", value: '-'),
                        CustomDivider(divider: 'Handling Information'),
                        BuildRow(
                          label: "Given By",
                          value: controller.detail['request_user_name'],
                        ),
                        controller.detail['received_user_name'] == null
                            ? BuildRow(
                              label: "Received By",
                              value: controller.detail['handover_user_name'],
                            )
                            : BuildRow(
                              label: "Received By",
                              value: controller.detail['received_user_name'],
                            ),
                      ],
                      CustomDivider(divider: 'Additional Information'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                'Proof Back to Base',
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textPrimary,
                                  fontSize: SizeConstant.TEXT_SIZE_HINT,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConstant.VERTICAL_PADDING,
                              ),
                              child: Text(
                                ":",
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textPrimary,
                                ),
                              ),
                            ),
                            Expanded(
                              child:
                                  controller.detail['returned_device_picture'] !=
                                          null
                                      ? GestureDetector(
                                        onTap: () async {
                                          controller.getImage(
                                            controller
                                                .detail['returned_device_picture'],
                                          );

                                          Get.dialog(
                                            Center(
                                              child:
                                                  LoadingAnimationWidget.flickr(
                                                    leftDotColor:
                                                        ColorConstants
                                                            .primaryColor,
                                                    rightDotColor:
                                                        ColorConstants
                                                            .secondaryColor,
                                                    size: 45,
                                                  ),
                                            ),
                                            barrierDismissible: false,
                                          );

                                          await Future.delayed(
                                            const Duration(seconds: 2),
                                          );

                                          Get.back();

                                          showImageDialog();
                                        },
                                        child: Text(
                                          'Open Image',
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.notoSans(
                                            decorationColor:
                                                ColorConstants.primaryColor,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationThickness: 2,
                                            fontStyle: FontStyle.italic,
                                            color: ColorConstants.primaryColor,
                                            fontSize: SizeConstant.TEXT_SIZE,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                      : Text(
                                        'Not Available',
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.notoSans(
                                          decorationColor:
                                              ColorConstants.primaryColor,
                                          decorationThickness: 2,
                                          fontStyle: FontStyle.italic,
                                          color: ColorConstants.primaryColor,
                                          fontSize: SizeConstant.TEXT_SIZE,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConstant.VERTICAL_PADDING,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                'Feedback Form',
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textPrimary,
                                  fontSize: SizeConstant.TEXT_SIZE_HINT,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: Text(
                                ":",
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textPrimary,
                                ),
                              ),
                            ),
                            Expanded(
                              child:
                                  controller.detail['feedback']
                                      ? GestureDetector(
                                        onTap: () async {
                                          Get.toNamed(
                                            AppRoutes
                                                .EFB_HISTORY_DETAIL_FEEDBACK,
                                            arguments: {
                                              'request_id':
                                                  controller
                                                      .detail['_id']['\$oid'],
                                              'history': controller.detail,
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Open Feedback',
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.notoSans(
                                            decorationColor:
                                                ColorConstants.primaryColor,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationThickness: 2,
                                            fontStyle: FontStyle.italic,
                                            color: ColorConstants.primaryColor,
                                            fontSize: SizeConstant.TEXT_SIZE,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                      : Text(
                                        'Not Available',
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.notoSans(
                                          fontStyle: FontStyle.italic,
                                          color: ColorConstants.primaryColor,
                                          fontSize: SizeConstant.TEXT_SIZE,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    });
  }

  Future<void> showImageDialog() async {
    Get.dialog(
      Dialog(
        backgroundColor: ColorConstants.backgroundColor,
        shadowColor: ColorConstants.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConstant.PADDING),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [Image.memory(controller.img.value!)],
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
