import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputDecoration {
  static customInputDecoration({required String labelText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: GoogleFonts.notoSans(
        color: ColorConstants.textPrimary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.blackColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.successColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.errorColor),
      ),
    );
  }

  static customInputDecorationWithIcon({
    required String labelText,
    required Icon icon,
  }) {
    return InputDecoration(
      suffixIcon: icon,
      labelText: labelText,
      labelStyle: GoogleFonts.notoSans(
        color: ColorConstants.textPrimary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.blackColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.successColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.errorColor),
      ),
    );
  }

  static customInputDecorationWithPrefixIcon({
    required String labelText,
    required Icon icon,
  }) {
    return InputDecoration(
      prefixIcon: icon,
      labelText: labelText,
      labelStyle: GoogleFonts.notoSans(
        color: ColorConstants.textPrimary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.blackColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.successColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.errorColor),
      ),
    );
  }

  static customInputDecorationReadOnly({required String labelText}) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.successColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
        borderSide: BorderSide(color: ColorConstants.successColor),
      ),
      labelText: labelText,
      labelStyle: GoogleFonts.notoSans(
        color: ColorConstants.textPrimary,
        fontSize: SizeConstant.TEXT_SIZE,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
