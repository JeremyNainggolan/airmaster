// ignore_for_file: camel_case_types
import 'package:airmaster/screens/home/ts_1/home/view/assessment/candidate/controller/candidate_assessment_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Candidate_View extends GetView<Candidate_Controller> {
  const Candidate_View({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController = TextEditingController(
      text: DateFormatter.convertDateTimeDisplay(DateTime.now().toString()),
    );

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final bool shouldPop = await _showBackDialog() ?? false;
          if (shouldPop) {
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
              final bool shouldPop = await _showBackDialog() ?? false;
              if (shouldPop) {
                Get.back();
              }
            },
          ),
          title: Text(
            "Assessment | Candidate",
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: SizeConstant.SUB_HEADING_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: ColorConstants.backgroundColor,
        body: Padding(
          padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          SizeConstant.BORDER_RADIUS,
                        ),
                        borderSide: BorderSide(
                          color: ColorConstants.blackColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          SizeConstant.BORDER_RADIUS,
                        ),
                        borderSide: BorderSide(
                          color: ColorConstants.blackColor,
                        ),
                      ),
                      labelText: 'Assessment Date',
                      labelStyle: GoogleFonts.notoSans(
                        color: ColorConstants.textPrimary,
                        fontSize: SizeConstant.TEXT_SIZE,
                        fontWeight: FontWeight.normal,
                      ),
                      suffixIcon: Icon(
                        Icons.calendar_month_outlined,
                        color: ColorConstants.blackColor,
                      ),
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

  Future<bool?> _showBackDialog() {
    return Get.dialog<bool>(
      AlertDialog(
        backgroundColor: ColorConstants.backgroundColor,
        title: Text(
          'Are you sure?',
          style: GoogleFonts.notoSans(
            color: ColorConstants.textPrimary,
            fontSize: SizeConstant.SUB_SUB_HEADING_SIZE,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Exiting will discard all changes made to this form and you have to start over.',
          style: GoogleFonts.notoSans(
            color: ColorConstants.textPrimary,
            fontSize: SizeConstant.TEXT_SIZE,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'No',
              style: GoogleFonts.notoSans(
                color: ColorConstants.primaryColor,
                fontSize: SizeConstant.TEXT_SIZE,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: () => Get.back(result: false),
          ),
          TextButton(
            child: Text(
              'Yes',
              style: GoogleFonts.notoSans(
                color: ColorConstants.primaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: () => Get.back(result: true),
          ),
        ],
      ),
    );
  }
}
