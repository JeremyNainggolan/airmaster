import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LegendWidget extends StatelessWidget {
  final List<Map<String, String>> items;
  const LegendWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      alignment: WrapAlignment.center,
      children:
          items
              .map((e) => _buildLegendItem(e.keys.first, e.values.first))
              .toList(),
    );
  }

  Widget _buildLegendItem(String name, String color) {
    Color parsedColor = Color(int.parse(color.replaceFirst('#', '0xff')));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: parsedColor),
        ),
        const SizedBox(width: 6),
        Text(
          name,
          style: GoogleFonts.notoSans(
            fontSize: 14,
            color: ColorConstants.textPrimary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
