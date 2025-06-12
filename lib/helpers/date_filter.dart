import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFilterWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fromController;
  final TextEditingController toController;
  final Color borderColor;
  final String fromLabel;
  final String toLabel;

  const DateFilterWidget({
    super.key,
    required this.formKey,
    required this.fromController,
    required this.toController,
    this.borderColor = Colors.blue,
    this.fromLabel = "From Date",
    this.toLabel = "To Date",
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: fromController,
              readOnly: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the From Date';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                prefixIcon: Icon(Icons.calendar_month, color: borderColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor.withOpacity(0.3)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: fromLabel,
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1945),
                  lastDate: DateTime(2300),
                );
                if (pickedDate != null) {
                  fromController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                }
              },
            ),
          ),
          const Expanded(
            flex: 1,
            child: Icon(Icons.compare_arrows_rounded),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: toController,
              readOnly: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the To Date';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                prefixIcon: Icon(Icons.calendar_month, color: borderColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor.withOpacity(0.3)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: toLabel,
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1945),
                  lastDate: DateTime(2300),
                );
                if (pickedDate != null) {
                  toController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
