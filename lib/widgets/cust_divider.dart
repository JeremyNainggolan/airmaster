import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required this.divider});

  final String divider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConstant.PADDING),
      child: Row(
        children: <Widget>[
          Expanded(child: Divider(color: Colors.grey)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConstant.HORIZONTAL_PADDING,
            ),
            child: Text(
              divider,
              style: GoogleFonts.notoSans(
                color: ColorConstants.textPrimary,
                fontSize: SizeConstant.TEXT_SIZE_HINT,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey)),
        ],
      ),
    );
  }
}
