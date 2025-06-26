import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssessmentFlightDetailsDropdownItem {
  static List<DropdownMenuItem<String>> getFlightDetailsDropdownItems(
    List<String> flightDetails,
  ) {
    return flightDetails.map((String flightDetail) {
      return DropdownMenuItem<String>(
        value: flightDetail,
        child: Text(
          flightDetail,
          style: GoogleFonts.notoSans(
            color: ColorConstants.textPrimary,
            fontSize: SizeConstant.TEXT_SIZE,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
    }).toList();
  }
}
