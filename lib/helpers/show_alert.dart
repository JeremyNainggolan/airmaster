import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

class ShowAlert {
  static Future<bool?> showBackAlert(BuildContext dialogContext) async {
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

  static Future<bool?> showErrorAlert(
    BuildContext dialogContext,
    String title,
    String message,
  ) async {
    return await QuickAlert.show(
      context: dialogContext,
      type: QuickAlertType.error,
      title: title,
      text: message,
      confirmBtnTextStyle: GoogleFonts.notoSans(
        color: ColorConstants.textSecondary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
      confirmBtnText: 'Okay',
      onConfirmBtnTap: () {
        Get.back();
        Get.back(result: true);
      },
    );
  }

  static Future<bool?> showSuccessAlert(
    BuildContext dialogContext,
    String title,
    String message,
  ) async {
    return await QuickAlert.show(
      barrierDismissible: false,
      context: Get.context!,
      type: QuickAlertType.success,
      title: title,
      text: message,
      confirmBtnTextStyle: GoogleFonts.notoSans(
        color: ColorConstants.textSecondary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
      onConfirmBtnTap: () async {
        Get.back();
        Get.back();
        Get.back(result: true);
      },
    );
  }

  static Future<bool?> showFetchSuccess(
    BuildContext dialogContext,
    String title,
    String message,
  ) async {
    return await QuickAlert.show(
      barrierDismissible: false,
      context: Get.context!,
      type: QuickAlertType.success,
      title: title,
      text: message,
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
  }

  static Future<bool?> showConfirmAlert(
    BuildContext dialogContext,
    String title,
    String message,
  ) async {
    return await QuickAlert.show(
      context: dialogContext,
      type: QuickAlertType.confirm,
      title: title,
      text: message,
      confirmBtnTextStyle: GoogleFonts.notoSans(
        color: ColorConstants.textSecondary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
      cancelBtnTextStyle: GoogleFonts.notoSans(
        color: ColorConstants.textPrimary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
      cancelBtnText: 'Cancel',
      confirmBtnText: 'Okay',
      onConfirmBtnTap: () {
        Get.back(result: true);
      },
    );
  }

  static Future<bool?> showLoadingAlert(
    BuildContext dialogContext,
    String title,
    String message,
  ) async {
    return await QuickAlert.show(
      context: dialogContext,
      type: QuickAlertType.loading,
      title: title,
      text: message,
      barrierDismissible: false,
      confirmBtnTextStyle: GoogleFonts.notoSans(
        color: ColorConstants.textSecondary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
