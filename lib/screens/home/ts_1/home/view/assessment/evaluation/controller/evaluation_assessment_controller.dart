// ignore_for_file: camel_case_types

import 'package:airmaster/model/assessment/evaluation/evaluation.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class Evaluation_Controller extends GetxController {
  final formKey = GlobalKey<FormState>();

  RxMap mainEvaluationData = {}.obs;
  RxMap humanEvaluationData = {}.obs;

  RxMap firstCrewMainEvaluationData = {}.obs;
  RxMap firstCrewHumanEvaluationData = {}.obs;

  RxMap secondCrewMainEvaluationData = {}.obs;
  RxMap secondCrewHumanEvaluationData = {}.obs;

  @override
  void onInit() {
    super.onInit();
    addEvaluation();
  }

  void addEvaluation() {
    mainEvaluationData.value = Map<String, dynamic>.from(
      Evaluation.mainEvaluationData,
    );
    humanEvaluationData.value = Map<String, dynamic>.from(
      Evaluation.humanEvaluationData,
    );
    firstCrewMainEvaluationData.value = Map<String, dynamic>.from(
      Evaluation.mainEvaluationData,
    );
    firstCrewHumanEvaluationData.value = Map<String, dynamic>.from(
      Evaluation.humanEvaluationData,
    );
    secondCrewMainEvaluationData.value = Map<String, dynamic>.from(
      Evaluation.mainEvaluationData,
    );
    secondCrewHumanEvaluationData.value = Map<String, dynamic>.from(
      Evaluation.humanEvaluationData,
    );
  }
}
