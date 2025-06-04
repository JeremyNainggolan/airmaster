import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ShowBackAlert {
  static Future<bool?> showAlert(BuildContext dialogContext) async {
    return await QuickAlert.show(
      context: dialogContext,
      type: QuickAlertType.warning,
      title: 'Are you sure?',
      text:
          'Exiting will discard all changes made to this form and you have to start over.',
      confirmBtnTextStyle: GoogleFonts.notoSans(
        color: ColorConstants.textSecondary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
      confirmBtnText: 'Yes',
      onConfirmBtnTap: () {
        Get.back(result: true);
      },
    );
  }
}
