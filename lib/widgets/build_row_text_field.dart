import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildRowWithTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const BuildRowWithTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: GoogleFonts.notoSans(
                    color: ColorConstants.textPrimary,
                    fontSize: SizeConstant.TEXT_SIZE_HINT,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                ":",
                style: GoogleFonts.notoSans(
                  color: ColorConstants.textPrimary,
                  fontSize: SizeConstant.TEXT_SIZE_HINT,
                ),
              ),
            ),

            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: TextFormField(
                  controller: controller,
                  style: GoogleFonts.notoSans(
                    color: ColorConstants.textPrimary,
                    fontSize: SizeConstant.TEXT_SIZE,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 12.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
