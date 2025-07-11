// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/home/home_administrator/controller/tc_home_administrator_controller.dart';
import 'package:airmaster/screens/home/training_card/home/home_cpts/controller/tc_home_cpts_controller.dart';
import 'package:airmaster/screens/home/training_card/home/home_examinee/controller/tc_home_examinee_controller.dart';
import 'package:airmaster/screens/home/training_card/home/home_instructor/controller/tc_home_instructor_controller.dart';
import 'package:airmaster/screens/home/training_card/profile/controller/tc_profile_controller.dart';
import 'package:airmaster/screens/home/training_card/training/controller/tc_training_controller.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/controller/tc_pilot_crew_controller.dart';
import 'package:airmaster/screens/home/training_card/training_list/controller/examainee_training_list_controller.dart';
import 'package:get/get.dart';

class TC_Main_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Home_Administrator_Controller>(() => TC_Home_Administrator_Controller());
    Get.lazyPut<TC_Home_CPTS_Controller>(() => TC_Home_CPTS_Controller());
    Get.lazyPut<TC_Home_Instructor_Controller>(() => TC_Home_Instructor_Controller());
    Get.lazyPut<TC_Home_Examinee_Controller>(() => TC_Home_Examinee_Controller());
    Get.lazyPut<TC_TrainingList_Controller>(() => TC_TrainingList_Controller());
    Get.lazyPut<TC_Training_Controller>(() => TC_Training_Controller());
    Get.lazyPut<TC_PilotCrew_Controller>(() => TC_PilotCrew_Controller());
    Get.lazyPut<TC_Profile_Controller>(() => TC_Profile_Controller());
  }
}
