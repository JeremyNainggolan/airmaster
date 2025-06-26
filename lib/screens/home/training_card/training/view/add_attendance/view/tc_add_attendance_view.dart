// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/training/view/add_attendance/controller/tc_add_attendance_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:airmaster/widgets/date_picker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:quickalert/quickalert.dart';

class TC_AddAttendance extends GetView<TC_AddAttendanceController> {
  TC_AddAttendance({super.key});

  final trainingName = Get.arguments;

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
          'Add Attendance',
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

                Builder(
                  builder: (context) {
                    if (controller.trainingAttendanceName.text.isEmpty &&
                        trainingName != null) {
                      controller.trainingAttendanceName.text = trainingName;
                    }
                    return TextFormField(
                      controller: controller.trainingAttendanceName,
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == " ") {
                          return 'Please enter the Subject';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 10,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.borderColor,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Training Name",
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),

                FormDateField(
                  text: 'Date',
                  textController: controller.trainingAttendanceDate,
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
                        ['Initial', 'Recurrent']
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e, overflow: TextOverflow.ellipsis),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      controller.trainingAttendanceType.value = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value == 'NONE') {
                        return 'Please select a training type';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    dropdownColor: ColorConstants.backgroundColor,
                    decoration: InputDecoration(
                      labelText: "Department",
                      border: OutlineInputBorder(),
                    ),
                    items:
                        ['Filght Ops']
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e, overflow: TextOverflow.ellipsis),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      controller.trainingAttendanceDepartment.value = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value == 'NONE') {
                        return 'Please select a training type';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    dropdownColor: ColorConstants.backgroundColor,
                    decoration: InputDecoration(
                      labelText: "Room",
                      border: OutlineInputBorder(),
                    ),
                    items:
                        [
                              'Throttle',
                              'Wing Tip',
                              'Sharklet',
                              'Windshear',
                              'Joy Stick',
                              'Fuselage',
                            ]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e, overflow: TextOverflow.ellipsis),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      controller.trainingAttendanceRoom.value = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value == 'NONE') {
                        return 'Please select a training type';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    dropdownColor: ColorConstants.backgroundColor,
                    decoration: InputDecoration(
                      labelText: "Venue",
                      border: OutlineInputBorder(),
                    ),
                    items:
                        ['IAA RH']
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e, overflow: TextOverflow.ellipsis),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      controller.trainingAttendanceVenue.value = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value == 'NONE') {
                        return 'Please select a training type';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),

                TypeAheadField<Instructor>(
                  controller: controller.instructorController,
                  builder: (context, textController, focusNode) {
                    return TextFormField(
                      controller: textController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        labelText: 'Instructor',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select user by finding name';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    );
                  },
                  suggestionsCallback: (pattern) async {
                    return await controller.getInstructorSuggestions(pattern);
                  },
                  itemBuilder: (context, Instructor suggestion) {
                    return ListTile(
                      textColor: ColorConstants.backgroundColor,
                      title: Text(
                        '${suggestion.name} (${suggestion.id})',
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: SizeConstant.TEXT_SIZE,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  emptyBuilder: (context) {
                    return ListTile(
                      title: Text(
                        'No users found.',
                        style: GoogleFonts.notoSans(
                          color: ColorConstants.textPrimary,
                          fontSize: SizeConstant.TEXT_SIZE,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      tileColor: ColorConstants.backgroundColor,
                    );
                  },
                  onSelected: (Instructor suggestion) {
                    controller.instructorController.text =
                        '${suggestion.name} (${suggestion.id})';
                    controller.selectedInstructorId.value = suggestion.id;
                  },
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        final response = await controller.saveAttendance();
                        if (response == true) {
                          QuickAlert.show(
                            context: Get.context!,
                            type: QuickAlertType.success,
                            text: 'Add Training Completed Successfully',
                            onConfirmBtnTap: () {
                              Get.back();
                              Get.back();
                            },
                            confirmBtnTextStyle: GoogleFonts.notoSans(
                              color: ColorConstants.textSecondary,
                              fontSize: SizeConstant.TEXT_SIZE_HINT,
                              fontWeight: FontWeight.normal,
                            ),
                          );
                        }
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
