import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:airmaster/utils/const_color.dart';

class FormDateField extends StatelessWidget {
  final TextEditingController textController;
  final String text;
  final bool readOnly;

  const FormDateField({
    super.key,
    required this.text,
    required this.textController,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      readOnly: true, // Always readOnly to trigger date picker
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the $text';
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.calendar_month,
          color: ColorConstants.primaryColor,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.backgroundColor,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        labelText: "Date",
      ),

      onTap: () async {
        if (!readOnly) {
          final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1945),
          lastDate: DateTime(2300),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: ColorConstants.primaryColor,     // Warna header dan tanggal terpilih
                  onPrimary: Colors.white,                  // Warna teks di header
                  onSurface: ColorConstants.textPrimary,   // Warna teks di tanggal
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: ColorConstants.primaryColor, // Tombol OK/Cancel
                  ),
                ),
              ),
              child: child!,
            );
          },
        );

          if (pickedDate != null) {
            final formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);
            textController.text = formattedDate;
          }
        }
      },
    );
  }
}
