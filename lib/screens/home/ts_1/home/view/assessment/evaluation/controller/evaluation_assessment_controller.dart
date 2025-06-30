// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:airmaster/model/assessment/evaluation/evaluation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Evaluation_Controller extends GetxController {
  dynamic params = Get.arguments;

  final formKey = GlobalKey<FormState>();

  final RxMap mainEvaluationData = {}.obs;
  final RxMap humanEvaluationData = {}.obs;

  final RxMap firstCrewMainEvaluationData = {}.obs;
  final RxMap firstCrewHumanEvaluationData = {}.obs;

  final RxMap secondCrewMainEvaluationData = {}.obs;
  final RxMap secondCrewHumanEvaluationData = {}.obs;

  final candidate = {}.obs;
  final candidateAnotated = {}.obs;
  final evaluation = {}.obs;

  final isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await addEvaluation();
    candidate.value = params['candidate'];
    candidateAnotated.value = params['candidateAnotated'];
  }

  Future<void> addEvaluation() async {
    isLoading.value = true;
    try {
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
    } catch (e) {
      log("Error in addEvaluation: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setEvaluation() async {
    evaluation.value = {
      'first_candidate': {
        'main_evaluation': firstCrewMainEvaluationData,
        'human_evaluation': firstCrewHumanEvaluationData,
      },
      'second_candidate': {
        'main_evaluation': secondCrewMainEvaluationData,
        'human_evaluation': secondCrewHumanEvaluationData,
      },
    };
  }
}
