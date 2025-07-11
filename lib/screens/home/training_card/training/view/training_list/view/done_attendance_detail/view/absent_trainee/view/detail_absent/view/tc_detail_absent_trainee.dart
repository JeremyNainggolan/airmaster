import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_attendance_detail/view/absent_trainee/view/detail_absent/controller/tc_detail_absent_trainee_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TC_Detail_AbsentTrainee
    extends GetView<TC_Detail_AbsentTrainee_Controller> {
  const TC_Detail_AbsentTrainee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.activeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Detail Absent Trainee',
          style: TextStyle(
            color: ColorConstants.textSecondary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10.0,
                ),
                child: Card(
                  color: ColorConstants.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 60.0,
                              bottom: 20.0,
                            ),
                            child: Container(
                              height: 150.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    spreadRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child:
                                    controller.trainee['photo_url'] != null
                                        ? Image.network(
                                          controller.trainee['photo_url'],
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Icon(Icons.broken_image),
                                          fit: BoxFit.cover,
                                        )
                                        : CircleAvatar(
                                          backgroundColor: Colors.blueGrey,
                                          child: Text(
                                            (controller.trainee['trainee_name'] ??
                                                    '?')
                                                .toString()
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style: GoogleFonts.notoSans(
                                              fontSize: 72,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: SizeConstant.SPACING),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.trainee['trainee_name'],
                              style: GoogleFonts.notoSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: ColorConstants.textPrimary,
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.trainee['trainee_rank'],
                                  style: GoogleFonts.notoSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.hintColor,
                                  ),
                                ),

                                Text(
                                  ' | ${controller.trainee['trainee_id']}',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.hintColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Table(
                              columnWidths: const {
                                0: FixedColumnWidth(100),
                                1: FixedColumnWidth(20),
                                2: FlexColumnWidth(),
                              },
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      child: Text(
                                        "STATUS",
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ":",
                                      style: GoogleFonts.notoSans(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Card(
                                      color:
                                          controller.trainee['trainee_status'] ==
                                                  'VALID'
                                              ? ColorConstants.successColor
                                              : ColorConstants.errorColor,
                                      margin: const EdgeInsets.only(
                                        right: 20.0,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            controller
                                                    .trainee['trainee_status'] ??
                                                'NOT VALID',
                                            style: GoogleFonts.notoSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        top: 10.0,
                                      ),
                                      child: Text(
                                        "RANK",
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        ":",
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        top: 10.0,
                                      ),
                                      child: Text(
                                        controller.trainee['trainee_rank'] ??
                                            'UNKNOWN',
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        top: 10.0,
                                      ),
                                      child: Text(
                                        "Email",
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        ":",
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        top: 10.0,
                                      ),
                                      child: Text(
                                        controller.trainee['trainee_email'] ??
                                            'UNKNOWN',
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        top: 10.0,
                                      ),
                                      child: Text(
                                        "HUB",
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        ":",
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        top: 10.0,
                                      ),
                                      child: Text(
                                        controller.trainee['trainee_hub'] ??
                                            'UNKNOWN',
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        top: 10.0,
                                      ),
                                      child: Text(
                                        "LICENSE NO",
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        ":",
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        top: 10.0,
                                      ),
                                      child: Text(
                                        controller
                                                .trainee['trainee_licenseNo'] ??
                                            'UNKNOWN',
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        top: 10.0,
                                      ),
                                      child: Text(
                                        "ID NO",
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        ":",
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        top: 10.0,
                                      ),
                                      child: Text(
                                        controller.trainee['trainee_id'] ??
                                            'UNKNOWN',
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TRAINING",
                      style: GoogleFonts.notoSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          
                        },
                        icon: Icon(
                          Icons.print,
                          color: ColorConstants.textSecondary,
                        ),
                        label: Text(
                          "Save PDF",
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.textSecondary,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.pdfColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.trainingList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      color: ColorConstants.backgroundColor,
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: ColorConstants.borderColor),
                      ),
                      child: controller.trainee['trainee_status'] == 'NOT VALID'
                          ? ListTile(
                              leading: Icon(Icons.error, color: ColorConstants.errorColor, size: 30,),
                              title: Text(
                                controller.trainingList[index]['training']
                              ),
                              subtitle: Card(
                                child: Text('NOT VALID'),
                              ),
                            )
                          : ListTile(
                              leading: Icon(Icons.check_circle, color: ColorConstants.successColor, size: 30,),
                              title: Text(
                                controller.trainingList[index]['training']
                              ),
                              subtitle: Card(
                                color: ColorConstants.backgroundColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('VALID'),
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
