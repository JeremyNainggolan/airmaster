// ignore_for_file: camel_case_types

import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/efb/history/controller/efb_history_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:airmaster/widgets/input_decoration.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shimmer/shimmer.dart';

class EFB_History extends GetView<EFB_History_Controller> {
  const EFB_History({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.rank.value == 'OCC') {
        return Scaffold(
          backgroundColor: ColorConstants.backgroundColor,
          body: Padding(
            padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: false,
                        controller: controller.textSearchField,
                        decoration:
                            CustomInputDecoration.customInputDecorationWithPrefixIcon(
                              labelText: 'Search History',
                              icon: Icon(
                                Icons.search,
                                color: ColorConstants.blackColor,
                              ),
                            ),
                        onChanged: (value) {
                          controller.searchHistory(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeConstant.PADDING_MIN),
                      child: IconButton(
                        icon: Icon(Icons.filter_list, size: 32.0),
                        onPressed: () async {
                          _showFilterDialog();
                        },
                      ),
                    ),
                  ],
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
                                controller.occFilteredHistory.isEmpty
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
                                                'No History Found',
                                                style: GoogleFonts.notoSans(
                                                  color:
                                                      ColorConstants
                                                          .textPrimary,
                                                  fontSize:
                                                      SizeConstant
                                                          .TEXT_SIZE_HINT,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                    : ListView.builder(
                                      itemCount:
                                          controller.occFilteredHistory.length,
                                      itemBuilder: (context, index) {
                                        final history =
                                            controller
                                                .occFilteredHistory[index];
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
                                              Get.toNamed(
                                                AppRoutes.EFB_HISTORY_DETAIL,
                                                arguments: {'detail': history},
                                              );
                                            },
                                            leading: CircleAvatar(
                                              radius: 25,
                                              backgroundImage:
                                                  history['request_user_photo'] !=
                                                          null
                                                      ? NetworkImage(
                                                        history['request_user_photo'],
                                                      )
                                                      : AssetImage(
                                                            'assets/images/default_picture.png',
                                                          )
                                                          as ImageProvider,
                                            ),
                                            trailing: Icon(
                                              Icons.chevron_right,
                                              color: Colors.black,
                                            ),
                                            title: Text(
                                              history['request_user_name'],
                                              style: GoogleFonts.notoSans(
                                                color:
                                                    ColorConstants.textPrimary,
                                                fontSize:
                                                    SizeConstant.TEXT_SIZE + 2,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  history['request_user_rank'],
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant
                                                            .TEXT_SIZE_HINT,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  history['deviceno'],
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant
                                                            .TEXT_SIZE_HINT,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormatter.convertDateTimeDisplay(
                                                    history['request_date'],
                                                    'dd MMMM yyyy',
                                                  ),
                                                  style: GoogleFonts.notoSans(
                                                    color:
                                                        ColorConstants
                                                            .textPrimary,
                                                    fontSize:
                                                        SizeConstant
                                                            .TEXT_SIZE_HINT,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
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
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final isConfirmed = await ShowAlert.showConfirmAlert(
                Get.context!,
                'Export to Excel',
                'Are you sure you want to export the history to Excel?',
              );

              if (isConfirmed == true) {
                ShowAlert.showLoadingAlert(
                  Get.context!,
                  'Exporting to excel...',
                );

                final isSuccess = await controller.exportToExcel();
                Get.back();

                if (isSuccess == true) {
                  QuickAlert.show(
                    context: Get.context!,
                    type: QuickAlertType.success,
                    title: 'Success',
                    text: 'History exported successfully.',
                    onConfirmBtnTap: () {
                      Get.back();
                    },
                  );
                } else {
                  QuickAlert.show(
                    context: Get.context!,
                    type: QuickAlertType.error,
                    title: 'Error',
                    text: 'Failed to export history. Please try again later.',
                    onConfirmBtnTap: () {
                      Get.back();
                    },
                  );
                }
              }
            },
            child: Icon(
              Icons.playlist_add_circle_rounded,
              size: 38.0,
              color: ColorConstants.whiteColor,
            ),
          ),
        );
      }

      return Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        body: Padding(
          padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: false,
                      controller: controller.textSearchField,
                      decoration:
                          CustomInputDecoration.customInputDecorationWithPrefixIcon(
                            labelText: 'Search History',
                            icon: Icon(
                              Icons.search,
                              color: ColorConstants.blackColor,
                            ),
                          ),
                      onChanged: (value) {
                        controller.searchOtherHistory(value);
                      },
                    ),
                  ),
                ],
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
                              controller.otherFilteredHistory.isEmpty
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
                                              'No History Found',
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
                                    itemCount:
                                        controller.otherFilteredHistory.length,
                                    itemBuilder: (context, index) {
                                      final history =
                                          controller
                                              .otherFilteredHistory[index];
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
                                            Get.toNamed(
                                              AppRoutes.EFB_HISTORY_DETAIL,
                                              arguments: {'detail': history},
                                            );
                                          },
                                          leading: CircleAvatar(
                                            radius: 25,
                                            backgroundImage:
                                                history['request_user_photo'] !=
                                                        null
                                                    ? NetworkImage(
                                                      history['request_user_photo'],
                                                    )
                                                    : AssetImage(
                                                          'assets/images/default_picture.png',
                                                        )
                                                        as ImageProvider,
                                          ),
                                          trailing: Icon(
                                            Icons.chevron_right,
                                            color: Colors.black,
                                          ),
                                          title: Text(
                                            history['request_user_name'],
                                            style: GoogleFonts.notoSans(
                                              color: ColorConstants.textPrimary,
                                              fontSize:
                                                  SizeConstant.TEXT_SIZE + 2,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                history['request_user_rank'],
                                                style: GoogleFonts.notoSans(
                                                  color:
                                                      ColorConstants
                                                          .textPrimary,
                                                  fontSize:
                                                      SizeConstant
                                                          .TEXT_SIZE_HINT,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                history['deviceno'],
                                                style: GoogleFonts.notoSans(
                                                  color:
                                                      ColorConstants
                                                          .textPrimary,
                                                  fontSize:
                                                      SizeConstant
                                                          .TEXT_SIZE_HINT,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                DateFormatter.convertDateTimeDisplay(
                                                  history['request_date'],
                                                  'dd MMMM yyyy',
                                                ),
                                                style: GoogleFonts.notoSans(
                                                  color:
                                                      ColorConstants
                                                          .textPrimary,
                                                  fontSize:
                                                      SizeConstant
                                                          .TEXT_SIZE_HINT,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
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
    });
  }

  Future<void> _showFilterDialog() async {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: ColorConstants.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Obx(
          () => Padding(
            padding: EdgeInsets.all(SizeConstant.PADDING),
            child: Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: SizeConstant.PADDING),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Filter History",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSans(
                        fontSize: SizeConstant.SUB_HEADING_SIZE,
                        color: ColorConstants.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeConstant.PADDING),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onTap: () async {
                            await controller.selectFromDate();
                          },
                          readOnly: true,
                          autofocus: false,
                          controller: controller.fromDate,
                          decoration:
                              CustomInputDecoration.customInputDecorationReadOnly(
                                labelText: 'From Date',
                              ),
                        ),
                      ),
                      SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
                      Expanded(
                        child: TextField(
                          onTap: () async {
                            await controller.selectToDate();
                          },
                          readOnly: true,
                          autofocus: false,
                          controller: controller.toDate,
                          decoration:
                              CustomInputDecoration.customInputDecorationReadOnly(
                                labelText: 'To Date',
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConstant.PADDING_MIN,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: ColorConstants.whiteColor,
                            value: controller.doneCheckBox.value,
                            onChanged: (value) {
                              controller.doneCheckBox.value = value!;
                              controller.handoverCheckBox.value = !value;
                            },
                          ),
                          Text(
                            'Done',
                            style: GoogleFonts.notoSans(
                              fontSize: SizeConstant.TEXT_SIZE,
                              color: ColorConstants.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: ColorConstants.whiteColor,
                            value: controller.handoverCheckBox.value,
                            onChanged: (value) {
                              controller.handoverCheckBox.value = value!;
                              controller.doneCheckBox.value = !value;
                            },
                          ),
                          Text(
                            'Handover',
                            style: GoogleFonts.notoSans(
                              fontSize: SizeConstant.TEXT_SIZE,
                              color: ColorConstants.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConstant.PADDING_MIN,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.errorColor,
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () async {
                            controller.resetFilter();
                            Get.back();
                          },
                          child: Text(
                            'Reset',
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.successColor,
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () async {
                            controller.applyFilter();
                            Get.back();
                          },
                          child: Text(
                            'Apply',
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget shimmerList() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(radius: 25, backgroundColor: Colors.white),
              title: Container(
                height: 12,
                width: double.infinity,
                color: Colors.white,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Container(height: 10, width: 150, color: Colors.white),
                  SizedBox(height: 4),
                  Container(height: 10, width: 100, color: Colors.white),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
