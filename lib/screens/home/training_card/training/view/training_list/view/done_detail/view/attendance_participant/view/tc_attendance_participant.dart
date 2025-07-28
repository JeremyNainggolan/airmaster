import 'package:airmaster/screens/home/training_card/training/view/training_list/view/confirm_detail/view/attendance_participant/controller/tc_attendance_participant_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TC_Attendance_Participant
    extends GetView<TC_AttendanceParticipant_Controller> {
  const TC_Attendance_Participant({super.key});

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
        title: Text('Participant'),
        titleTextStyle: GoogleFonts.notoSans(
          color: ColorConstants.textSecondary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}