import 'dart:developer';

import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeviceList extends StatelessWidget {
  final List<Map<String, dynamic>> devices;
  final String emptyMessage;

  const DeviceList({
    super.key,
    required this.devices,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (devices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.device_hub,
              size: 50,
              color: ColorConstants.primaryColor,
            ),
            SizedBox(height: 10),
            Text(
              emptyMessage,
              style: GoogleFonts.notoSans(
                color: ColorConstants.textPrimary,
                fontSize: SizeConstant.TEXT_SIZE,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorConstants.blackColor),
            borderRadius: BorderRadius.circular(SizeConstant.BORDER_RADIUS),
          ),
          color: ColorConstants.backgroundColor,
          child: ListTile(
            onTap: () {
              log('Tapped on device: ${device['deviceno']}');
            },
            leading: Icon(Icons.device_hub),
            trailing: Icon(Icons.chevron_right, color: Colors.black),
            title: Text(
              device['deviceno'],
              style: GoogleFonts.notoSans(
                color: ColorConstants.textPrimary,
                fontSize: SizeConstant.TEXT_SIZE,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Request Date: ${DateFormatter.convertDateTimeDisplay(device['request_date'], "MMM d, yyyy")}',
              style: GoogleFonts.notoSans(
                color: ColorConstants.textPrimary,
                fontSize: SizeConstant.TEXT_SIZE_HINT,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}
