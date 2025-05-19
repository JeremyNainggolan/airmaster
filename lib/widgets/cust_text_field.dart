import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/widgets/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextCapitalization capitalization;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.capitalization = TextCapitalization.none,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConstant.VERTICAL_PADDING),
      child: TextFormField(
        controller: controller,
        cursorColor: ColorConstants.primaryColor,
        decoration: CustomInputDecoration.customInputDecoration(
          labelText: label,
        ),
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        textCapitalization: capitalization,
        inputFormatters: inputFormatters,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
      ),
    );
  }
}
