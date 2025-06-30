import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Overall_Perfom_Controller extends GetxController {
  final formKey = GlobalKey<FormState>();

  final RxString firstCrewPerformance = ''.obs;
  final RxString firstCrewRecommendation = ''.obs;
  final firstCrewNotes = TextEditingController();

  final RxString secondCrewPerformance = ''.obs;
  final RxString secondCrewRecommendation = ''.obs;
  final secondCrewNotes = TextEditingController();

  final performanceList = ['1', '2', '3', '4', '5'];

  final recomendationList = [
    'None',
    'Senior First Officer',
    'Ground Training Instructor',
    'Company Check Pilot',
    'Command Upgrade',
    'Type Rating Instructor',
    'Others',
  ];
}
