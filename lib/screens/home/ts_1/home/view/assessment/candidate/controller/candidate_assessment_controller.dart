// ignore_for_file: camel_case_types

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Candidate_Controller extends GetxController {
  final formKey = GlobalKey<FormState>();

  var firstCandidateName = ''.obs;
  var firstCandidateStaffNumber = ''.obs;
  var firstCandidateLicenseNumber = ''.obs;
  var firstCandidateLicenseExpiry = ''.obs;

  var secondCandidateName = ''.obs;
  var secondCandidateStaffNumber = ''.obs;
  var secondCandidateLicenseNumber = ''.obs;
  var secondCandidateLicenseExpiry = ''.obs;
}
