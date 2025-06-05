// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/training/view/new_training/controller/new_training_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TC_NewTraining extends GetView<TC_NewTrainingController> {
  const TC_NewTraining({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'New Training',
          style: GoogleFonts.notoSans(
            color: ColorConstants.textSecondary,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                //-------------------------SUBJECT-----------------------
                TextFormField(
                  controller: controller.subjectController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == " ") {
                      // Validation Logic
                      return 'Please enter the Subject';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
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
                    labelText: "Subject",
                  ),
                ),
                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    dropdownColor: ColorConstants.backgroundColor,
                    decoration: InputDecoration(
                      labelText: "Training Type",
                      border: OutlineInputBorder(),
                    ),
                    items:
                        [
                              'NONE',
                              '6 MONTH CALENDER',
                              '12 MONTH CALENDER',
                              '24 MONTH CALENDER',
                              '36 MONTH CALENDER',
                              'LAST MONTH ON THE NEXT YEAR OF THE PREVIOUS TRAINING',
                            ]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e, overflow: TextOverflow.ellipsis),
                              ),
                            )
                            .toList(),
                    onChanged: (value) => log('dropdown: $value'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value == 'NONE') {
                        return 'Please select a training type';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      // Validation Logic
                      return 'Please enter the Training Description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
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
                    labelText: "Training Description",
                  ),
                ),
                const SizedBox(height: 10),

                //-------------------------SUBMIT-----------------------
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.saveTraining().then(
                          (value) => Get.toNamed(AppRoutes.TC_TRAINING),
                        );
                      } else {
                        Get.snackbar(
                          'Error',
                          'Please fill all fields correctly',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: ColorConstants.errorColor,
                          colorText: Colors.white,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.successColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "Make sure every data is selected before pressing the submit button",
                    style: GoogleFonts.notoSans(
                      color: ColorConstants.textPrimary,
                      fontSize: SizeConstant.TEXT_SIZE_HINT,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
