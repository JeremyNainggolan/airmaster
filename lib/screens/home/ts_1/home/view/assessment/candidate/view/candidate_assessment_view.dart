// ignore_for_file: camel_case_types, deprecated_member_use
import 'package:airmaster/helpers/airport_route_formatter.dart';
import 'package:airmaster/helpers/show_alert.dart';
import 'package:airmaster/model/users/user.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/candidate/controller/candidate_assessment_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:airmaster/widgets/cust_divider.dart';
import 'package:airmaster/widgets/cust_text_field.dart';
import 'package:airmaster/helpers/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Candidate_View extends GetView<Candidate_Controller> {
  const Candidate_View({super.key});

  @override
  Widget build(BuildContext context) {
    List<User> searchedUsers = [];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final shouldPop = await ShowAlert.showBackAlert(Get.context!);

          if (shouldPop == true) {
            Get.back();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
            onPressed: () async {
              final shouldPop = await ShowAlert.showBackAlert(Get.context!);

              if (shouldPop == true) {
                Get.back();
              }
            },
          ),
          title: Text(
            "Assessment | Candidate",
            style: GoogleFonts.notoSans(
              color: ColorConstants.textSecondary,
              fontSize: SizeConstant.SUB_HEADING_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: ColorConstants.backgroundColor,
        body: Padding(
          padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConstant.VERTICAL_PADDING,
                        ),
                        child: TextFormField(
                          controller: controller.date,
                          readOnly: true,
                          decoration:
                              CustomInputDecoration.customInputDecorationReadOnly(
                                labelText: 'Assessment Date',
                              ),
                        ),
                      ),

                      CustomDivider(divider: 'Flight Crew 1'),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConstant.VERTICAL_PADDING,
                        ),
                        child: TypeAheadField<User>(
                          controller: controller.firstFlightCrewName,
                          builder: (context, _, focusNode) {
                            return TextFormField(
                              onTap: () {
                                controller.firstFlightCrewName.text = '';
                                controller.firstFlightCrewStaffNumber.text = '';
                                controller.firstFlightCrewLicense.text = '';
                                controller.firstFlightCrewLicenseExpiry.text =
                                    '';
                                focusNode.requestFocus();
                                controller.firstFlightCrewName.clear();
                              },
                              controller: controller.firstFlightCrewName,
                              focusNode: focusNode,
                              decoration:
                                  CustomInputDecoration.customInputDecoration(
                                    labelText: 'Flight Crew Name',
                                  ),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select user by finding name';
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            );
                          },
                          suggestionsCallback: (pattern) async {
                            Future.delayed(Duration(milliseconds: 500));
                            if (pattern.isNotEmpty) {
                              searchedUsers = await controller
                                  .getUsersBySearchName(pattern);
                              return searchedUsers;
                            } else {
                              return [];
                            }
                          },
                          itemBuilder: (context, User suggestion) {
                            return ListTile(
                              title: Text(
                                suggestion.name ?? '',
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textPrimary,
                                  fontSize: SizeConstant.TEXT_SIZE,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              tileColor: ColorConstants.backgroundColor,
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
                          onSelected: (User? suggestion) {
                            controller.firstFlightCrewName.text =
                                suggestion?.name ?? '';
                            controller.firstFlightCrewStaffNumber.text =
                                suggestion?.id_number ?? '';
                            controller.firstFlightCrewLicense.text =
                                suggestion?.license_number ?? '';
                            controller
                                .firstFlightCrewLicenseExpiry
                                .text = DateFormatter.convertDateTimeDisplay(
                              suggestion?.license_expiry.toString() ?? '',
                              "dd MMMM yyyy",
                            );
                          },
                          hideOnSelect: true,
                        ),
                      ),

                      // staff no
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConstant.VERTICAL_PADDING,
                        ),
                        child: TextFormField(
                          controller: controller.firstFlightCrewStaffNumber,
                          focusNode: FocusNode(),
                          decoration:
                              CustomInputDecoration.customInputDecoration(
                                labelText: 'Staff No.',
                              ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select user by finding name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            controller.firstFlightCrewStaffNumber.text = value;
                          },
                          readOnly: true,
                        ),
                      ),

                      // license no
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConstant.VERTICAL_PADDING,
                        ),
                        child: TextFormField(
                          controller: controller.firstFlightCrewLicense,
                          decoration:
                              CustomInputDecoration.customInputDecoration(
                                labelText: 'License No.',
                              ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select user by finding name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            controller.firstFlightCrewLicense.text = value;
                          },
                          readOnly: true,
                        ),
                      ),

                      // license expiry
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConstant.VERTICAL_PADDING,
                        ),
                        child: TextFormField(
                          controller: controller.firstFlightCrewLicenseExpiry,
                          decoration:
                              CustomInputDecoration.customInputDecoration(
                                labelText: 'License Expiry',
                              ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select user by finding name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            controller.firstFlightCrewLicenseExpiry.text =
                                value;
                          },
                          readOnly: true,
                        ),
                      ),

                      CustomDivider(divider: 'Flight Crew 2'),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConstant.VERTICAL_PADDING,
                        ),
                        child: TypeAheadField<User>(
                          controller: controller.secondFlightCrewName,
                          builder: (context, _, focusNode) {
                            return TextFormField(
                              onTap: () {
                                controller.secondFlightCrewName.text = '';
                                controller.secondFlightCrewStaffNumber.text =
                                    '';
                                controller.secondFlightCrewLicense.text = '';
                                controller.secondFlightCrewLicenseExpiry.text =
                                    '';
                                focusNode.requestFocus();
                                controller.secondFlightCrewName.clear();
                              },
                              controller: controller.secondFlightCrewName,
                              focusNode: focusNode,
                              decoration:
                                  CustomInputDecoration.customInputDecoration(
                                    labelText: 'Flight Crew Name',
                                  ),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select user by finding name';
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            );
                          },
                          suggestionsCallback: (pattern) async {
                            Future.delayed(Duration(milliseconds: 500));
                            if (pattern.isNotEmpty) {
                              searchedUsers = await controller
                                  .getUsersBySearchName(pattern);
                              return searchedUsers;
                            } else {
                              return [];
                            }
                          },
                          itemBuilder: (context, User suggestion) {
                            return ListTile(
                              title: Text(
                                suggestion.name ?? '',
                                style: GoogleFonts.notoSans(
                                  color: ColorConstants.textPrimary,
                                  fontSize: SizeConstant.TEXT_SIZE,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              tileColor: ColorConstants.backgroundColor,
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
                          onSelected: (User? suggestion) {
                            if (suggestion?.name ==
                                controller.firstFlightCrewName.text) {
                              controller.secondFlightCrewName.clear();
                              controller.secondFlightCrewStaffNumber.clear();
                              controller.secondFlightCrewLicense.clear();
                              controller.secondFlightCrewLicenseExpiry.clear();
                              Get.snackbar(
                                'Error',
                                'Please select a different user.',
                                backgroundColor: ColorConstants.primaryColor,
                                colorText: ColorConstants.textSecondary,
                                snackStyle: SnackStyle.FLOATING,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else {
                              controller.secondFlightCrewName.text =
                                  suggestion?.name ?? '';
                              controller.secondFlightCrewStaffNumber.text =
                                  suggestion?.id_number ?? '';
                              controller.secondFlightCrewLicense.text =
                                  suggestion?.license_number ?? '';
                              controller
                                  .secondFlightCrewLicenseExpiry
                                  .text = DateFormatter.convertDateTimeDisplay(
                                suggestion?.license_expiry.toString() ?? '',
                                "dd MMMM yyyy",
                              );
                            }
                          },
                          hideOnSelect: true,
                        ),
                      ),

                      // staff no
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConstant.VERTICAL_PADDING,
                        ),
                        child: TextFormField(
                          controller: controller.secondFlightCrewStaffNumber,
                          focusNode: FocusNode(),
                          decoration:
                              CustomInputDecoration.customInputDecoration(
                                labelText: 'Staff No.',
                              ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select user by finding name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            controller.secondFlightCrewStaffNumber.text = value;
                          },
                          readOnly: true,
                        ),
                      ),

                      // license no
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConstant.VERTICAL_PADDING,
                        ),
                        child: TextFormField(
                          controller: controller.secondFlightCrewLicense,
                          decoration:
                              CustomInputDecoration.customInputDecoration(
                                labelText: 'License No.',
                              ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select user by finding name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            controller.secondFlightCrewLicense.text = value;
                          },
                          readOnly: true,
                        ),
                      ),

                      // license expiry
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConstant.VERTICAL_PADDING,
                        ),
                        child: TextFormField(
                          controller: controller.secondFlightCrewLicenseExpiry,
                          decoration:
                              CustomInputDecoration.customInputDecoration(
                                labelText: 'License Expiry',
                              ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select user by finding name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            controller.secondFlightCrewLicenseExpiry.text =
                                value;
                          },
                          readOnly: true,
                        ),
                      ),

                      CustomDivider(divider: 'Other'),

                      // Aircraft Type
                      CustomTextField(
                        controller: controller.aircraftType,
                        label: 'Aircraft Type',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter aircraft type';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.aircraftType.text = value;
                        },
                      ),

                      // Airport Route
                      CustomTextField(
                        controller: controller.airportAndRoute,
                        label: 'Airport & Route (AAA-BBB-CCC)',
                        capitalization: TextCapitalization.characters,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[A-Z]')),
                          LengthLimitingTextInputFormatter(9),
                          AirportRouteFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter airport & route';
                          }
                          if (!RegExp(
                            r'^[A-Z]{3}-[A-Z]{3}-[A-Z]{3}$',
                          ).hasMatch(value)) {
                            return "Enter in the format of ABC-DEF-GHI";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.airportAndRoute.text = value;
                        },
                      ),

                      // Simulation Hours
                      CustomTextField(
                        controller: controller.simulationHours,
                        label: 'Simulation Hours (hh:mm)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter simulation hours';
                          }
                          if (!RegExp(
                            r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$',
                          ).hasMatch(value)) {
                            return "Enter in the format of hh:mm";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.simulationHours.text = value;
                        },
                      ),

                      // Simulation Identity
                      CustomTextField(
                        controller: controller.simulationIdentity,
                        label: 'Simulation Identity',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter simulation identity';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.simulationIdentity.text = value;
                        },
                      ),

                      // LOA No.
                      CustomTextField(
                        controller: controller.loaNumber,
                        label: 'LOA No.',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter LOA No.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.loaNumber.text = value;
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(SizeConstant.PADDING),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () async {
              await controller.setCandidateAssessment();

              if (controller.formKey.currentState!.validate()) {
                Get.toNamed(
                  AppRoutes.TS1_FLIGHT_DETAILS,
                  arguments: {'candidate': controller.candidate},
                );
              } else {
                ShowAlert.showInfoAlert(
                  Get.context!,
                  'Caution!',
                  'Please fill all required fields correctly.',
                );
              }
            },
            child: Text(
              'Next',
              style: GoogleFonts.notoSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
