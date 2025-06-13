// ignore_for_file: camel_case_types

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/efb/history/controller/efb_history_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:airmaster/widgets/input_decoration.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EFB_History extends GetView<EFB_History_Controller> {
  const EFB_History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Obx(
        () => Padding(
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
                child: RefreshIndicator(
                  onRefresh: controller.refreshData,
                  child:
                      controller.filteredHistory.isEmpty
                          ? ListView(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.device_hub,
                                      size: 40,
                                      color: ColorConstants.primaryColor,
                                    ),
                                    Text(
                                      'No History Found',
                                      style: GoogleFonts.notoSans(
                                        color: ColorConstants.textPrimary,
                                        fontSize: SizeConstant.TEXT_SIZE_HINT,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                          : ListView.builder(
                            itemCount: controller.filteredHistory.length,
                            itemBuilder: (context, index) {
                              final history = controller.filteredHistory[index];
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
                                        history['user_photo'] != null
                                            ? NetworkImage(
                                              history['user_photo'],
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
                                    history['user_name'],
                                    style: GoogleFonts.notoSans(
                                      color: ColorConstants.textPrimary,
                                      fontSize: SizeConstant.TEXT_SIZE + 2,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        history['user_rank'],
                                        style: GoogleFonts.notoSans(
                                          color: ColorConstants.textPrimary,
                                          fontSize: SizeConstant.TEXT_SIZE_HINT,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        history['deviceno'],
                                        style: GoogleFonts.notoSans(
                                          color: ColorConstants.textPrimary,
                                          fontSize: SizeConstant.TEXT_SIZE_HINT,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        DateFormatter.convertDateTimeDisplay(
                                          history['request_date'],
                                          'dd MMMM yyyy',
                                        ),
                                        style: GoogleFonts.notoSans(
                                          color: ColorConstants.textPrimary,
                                          fontSize: SizeConstant.TEXT_SIZE_HINT,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.playlist_add_circle_rounded,
          size: 38.0,
          color: ColorConstants.whiteColor,
        ),
      ),
    );
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
}
