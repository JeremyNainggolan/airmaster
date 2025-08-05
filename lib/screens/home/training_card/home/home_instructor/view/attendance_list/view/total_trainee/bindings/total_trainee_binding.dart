import 'package:airmaster/screens/home/training_card/home/home_instructor/view/attendance_list/view/total_trainee/controller/total_trainee_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Instructor Total Trainee Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Instructor Total Trainee feature.
  | It manages the dependencies for the total trainee controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class Ins_TotalTrainee_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Ins_TotalTrainee_Controller>(
      () => Ins_TotalTrainee_Controller(),
    );
  }
}
