import 'package:airmaster/screens/home/efb/history/view/history-detail/view/feedback/view/format-pdf/controller/format_pdf_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/build_row.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Format_Pdf_View extends GetView<Format_Pdf_Controller> {
  const Format_Pdf_View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () {
            Get.back();
          },
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
      body: Obx(
        () => Padding(
          padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Feedback PDF Format',
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
                    BuildRow(
                      label: 'Rec No.',
                      value: controller.format['rec_number'],
                    ),
                    BuildRow(label: 'Date ', value: controller.format['date']),
                    SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
                    Text(
                      'Footer',
                      style: GoogleFonts.notoSans(
                        fontSize: SizeConstant.TEXT_SIZE,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    BuildRow(
                      label: 'Footer Left',
                      value: controller.format['left_footer'],
                    ),
                    BuildRow(
                      label: 'Footer Right ',
                      value: controller.format['right_footer'],
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
                          onPressed: () {},
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
        ),
      ),
    );
  }
}
