import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildRowRedValue extends StatelessWidget {
  final String label;
  final String value;

  const BuildRowRedValue({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 150, child: buildTextKey(label)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              ":",
              style: GoogleFonts.notoSans(color: ColorConstants.textPrimary),
            ),
          ),
          Expanded(child: buildTextValue(value.isNotEmpty ? value : "-")),
        ],
      ),
    );
  }

  Widget buildTextKey(String text) {
    return Text(
      text,
      style: GoogleFonts.notoSans(
        color: ColorConstants.textPrimary,
        fontSize: SizeConstant.TEXT_SIZE_HINT,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget buildTextValue(String text) {
    return Text(
      text,
      textAlign: TextAlign.end,
      style: GoogleFonts.notoSans(
        color: ColorConstants.textTertiary,
        fontSize: SizeConstant.TEXT_SIZE,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
