// ignore_for_file: constant_identifier_names

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/auth/login.dart';
import 'package:airmaster/screens/home/dashboard.dart';
import 'package:airmaster/screens/home/efb/history/view/history-detail/bindings/history_detail_binding.dart';
import 'package:airmaster/screens/home/efb/history/view/history-detail/view/feedback/bindings/detail_feedback_binding.dart';
import 'package:airmaster/screens/home/efb/history/view/history-detail/view/feedback/view/detail_feedback_view.dart';
import 'package:airmaster/screens/home/efb/history/view/history-detail/view/feedback/view/format-pdf/bindings/format_pdf_binding.dart';
import 'package:airmaster/screens/home/efb/history/view/history-detail/view/feedback/view/format-pdf/view/format_pdf_view.dart';
import 'package:airmaster/screens/home/efb/history/view/history-detail/view/handover-log-format/bindings/handover_log_format_binding.dart';
import 'package:airmaster/screens/home/efb/history/view/history-detail/view/handover-log-format/view/handover_log_format_view.dart';
import 'package:airmaster/screens/home/efb/history/view/history-detail/view/history_detail_view.dart';
import 'package:airmaster/screens/home/efb/home/view/accept-handover/bindings/accept_handover_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/accept-handover/view/accept_handover_view.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/handover/bindings/pilot_handover_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/handover/view/pilot_handover_view.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/return-occ/bindings/occ_return_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/return-occ/view/occ_return_view.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/handover/bindings/fo_handover_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/handover/view/fo_handover_view.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/bindings/fo_used_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/firstpage/bindings/fo_feedback_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/firstpage/view/fo_feedback_view.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/secondpage/bindings/fo_battery_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/secondpage/view/fo_battery_view.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/thirdpage/bindings/fo_confirm_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/thirdpage/view/fo_confirm_view.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/fo_used_view.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/request/bindings/fo_request_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/request/view/fo_request_view.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/waiting-confirmation/bindings/fo_waiting_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/fo-pages/waiting-confirmation/view/fo_waiting_view.dart';
import 'package:airmaster/screens/home/efb/home/view/occ-pages/request/bindings/occ_requested_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/occ-pages/request/view/occ_requested_view.dart';
import 'package:airmaster/screens/home/efb/home/view/occ-pages/return/bindings/occ_returned_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/occ-pages/return/view/occ_returned_view.dart';
import 'package:airmaster/screens/home/efb/home/view/occ-pages/used/bindings/occ_used_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/occ-pages/used/view/occ_used_view.dart';
import 'package:airmaster/screens/home/training_card/home/home_cpts/bindings/tc_home_cpts_binding.dart';
import 'package:airmaster/screens/home/training_card/home/home_cpts/view/tc_home_cpts.dart';
import 'package:airmaster/screens/home/training_card/home/home_examinee/bindings/tc_home_examinee_binding.dart';
import 'package:airmaster/screens/home/training_card/home/home_examinee/view/feedback/bindings/tc_feedback_required_bindings.dart';
import 'package:airmaster/screens/home/training_card/home/home_examinee/view/feedback/view/examinee_feedback/bindings/tc_examinee_feedback_binding.dart';
import 'package:airmaster/screens/home/training_card/home/home_examinee/view/feedback/view/examinee_feedback/view/tc_examinee_feedback.dart';
import 'package:airmaster/screens/home/training_card/home/home_examinee/view/feedback/view/tc_feedback_required.dart';
import 'package:airmaster/screens/home/training_card/home/home_examinee/view/tc_home_examinee.dart';
import 'package:airmaster/screens/home/training_card/home/home_instructor/bindings/tc_home_instructor_binding.dart';
import 'package:airmaster/screens/home/training_card/home/home_instructor/view/attendance_list/bindings/ins_attendance_list_binding.dart';
import 'package:airmaster/screens/home/training_card/home/home_instructor/view/attendance_list/view/ins_attendance_list.dart';
import 'package:airmaster/screens/home/training_card/home/home_instructor/view/attendance_list/view/total_trainee/view/scoring_trainee/binding/scoring_trainee_bindings.dart';
import 'package:airmaster/screens/home/training_card/home/home_instructor/view/attendance_list/view/total_trainee/view/scoring_trainee/view/scoring_trainee.dart';
import 'package:airmaster/screens/home/training_card/home/home_instructor/view/tc_home_instructor.dart';
import 'package:airmaster/screens/home/training_card/home/home_instructor/view/attendance_list/view/total_trainee/bindings/total_trainee_binding.dart';
import 'package:airmaster/screens/home/training_card/home/home_instructor/view/attendance_list/view/total_trainee/view/total_trainee.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/bindings/tc_pilot_crew_binding.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/bindings/tc_profile_pilot_bindings.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/view/tc_pilot_training_history/bingings/tc_pilot_training_history_binding.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/view/tc_pilot_training_history/view/tc_detail_pilot_histroy/bindings/tc_detail_pilot_history_binding.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/view/tc_pilot_training_history/view/tc_detail_pilot_histroy/view/tc_detail_pilot_history.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/view/tc_pilot_training_history/view/tc_pilot_training_history.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/view/profile_pilot/view/tc_profile_pilot.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/view/tc_pilot_crew.dart';
import 'package:airmaster/screens/home/training_card/profile_examinee/bindings/tc_profile_examinee_binding.dart';
import 'package:airmaster/screens/home/training_card/profile_examinee/view/tc_profile_examinee.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/confirm_detail/bindings/tc_attendance_detail_confirm_bindings.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/confirm_detail/view/tc_attendance_detail_confirm.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/bindings/tc_attendance_detail_done_bindings.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/bindings/tc_absent_trainee_binding.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/view/detail_absent/bindings/tc_detail_absent_binding.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/view/detail_absent/view/tc_detail_absent_trainee.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/view/detail_absent/view/training_history/bindings/tc_training_history_binding.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_attendance_detail/view/absent_trainee/view/detail_absent/view/training_history/view/detail_training_history/bindings/detail_training_history_binding.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/view/detail_absent/view/training_history/view/detail_history/view/history.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/view/detail_absent/view/training_history/view/tc_training_history.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/view/tc_absent_trainee.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/tc_attendance_detail_done.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/pending_detail/bindings/tc_attendance_detail_pending_bindings.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/pending_detail/view/tc_attendance_detail_pending.dart';
import 'package:airmaster/screens/home/training_card/training_list/bindings/examinee_training_list_binding.dart';
import 'package:airmaster/screens/home/training_card/training_list/view/attendance_detail/bindings/examinee_attendance_detail_binding.dart';
import 'package:airmaster/screens/home/training_card/training_list/view/attendance_detail/view/examinee_attendance_detail.dart';
import 'package:airmaster/screens/home/training_card/training_list/view/create_attendance/binding/examinee_create_attendance_binding.dart';
import 'package:airmaster/screens/home/training_card/training_list/view/create_attendance/view/examinee_create_attendance.dart';
import 'package:airmaster/screens/home/training_card/training_list/view/examinee_training_list.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/declaration/bindings/declaration_binding.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/declaration/view/declaration_view.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/overall_performance/bindings/overall_perform_binding.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/overall_performance/view/overall_perform_view.dart';
import 'package:get/get.dart';
import 'package:airmaster/screens/home/efb/analytics/bindings/efb_analytics_binding.dart';
import 'package:airmaster/screens/home/efb/analytics/view/efb_analytics.dart';
import 'package:airmaster/screens/home/efb/devices/bindings/efb_device_binding.dart';
import 'package:airmaster/screens/home/efb/devices/view/efb_device.dart';
import 'package:airmaster/screens/home/efb/history/bindings/efb_history_binding.dart';
import 'package:airmaster/screens/home/efb/history/view/efb_history.dart';
import 'package:airmaster/screens/home/efb/home/bindings/efb_home_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/bindings/request_detail_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/feedback/firstpage/bindings/feedback_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/feedback/firstpage/view/feedback_view.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/feedback/secondpage/bindings/battery_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/feedback/secondpage/view/battery_view.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/feedback/thirdpage/bindings/confirm_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/feedback/thirdpage/view/confirm_view.dart';
import 'package:airmaster/screens/home/efb/home/view/detail/view/request_detail_view.dart';
import 'package:airmaster/screens/home/efb/home/view/efb_home.dart';
import 'package:airmaster/screens/home/efb/home/view/request/bindings/request_device_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/request/view/request_device_view.dart';
import 'package:airmaster/screens/home/efb/main/bindings/efb_main_binding.dart';
import 'package:airmaster/screens/home/efb/main/view/efb_view.dart';
import 'package:airmaster/screens/home/efb/profile/bindings/efb_profile_binding.dart';
import 'package:airmaster/screens/home/efb/profile/view/efb_profile.dart';
import 'package:airmaster/screens/home/ts_1/analytics/view/ts1_analytics.dart';
import 'package:airmaster/screens/home/ts_1/history/view/ts1_history.dart';
import 'package:airmaster/screens/home/ts_1/home/bindings/ts1_home_binding.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/candidate/bindings/candidate_assessment_binding.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/candidate/view/candidate_assessment_view.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/evaluation/bindings/evaluation_assessment_binding.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/evaluation/view/evaluation_assessment_view.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/flight_details/bindings/flightdetails_assessment_binding.dart';
import 'package:airmaster/screens/home/ts_1/home/view/assessment/flight_details/view/flightdetails_assessment_view.dart';
import 'package:airmaster/screens/home/ts_1/home/view/ts1_home.dart';
import 'package:airmaster/screens/home/ts_1/main/bindings/ts1_main_binding.dart';
import 'package:airmaster/screens/home/ts_1/main/view/ts1_view.dart';
import 'package:airmaster/screens/home/ts_1/profile/bindings/ts1_profile_binding.dart';
import 'package:airmaster/screens/home/ts_1/profile/view/ts1_profile.dart';
import 'package:airmaster/screens/maintenance/under_maintenance.dart';
import 'package:airmaster/screens/home/training_card/main/tc_view.dart';
import 'package:airmaster/screens/home/training_card/main/bindings/tc_main_binding.dart';
import 'package:airmaster/screens/home/training_card/home/home_administrator/view/tc_home_administrator.dart';
import 'package:airmaster/screens/home/training_card/home/home_administrator/bindings/tc_home_administrator_binding.dart';
import 'package:airmaster/screens/home/training_card/profile/view/tc_profile.dart';
import 'package:airmaster/screens/home/training_card/profile/bindings/tc_profile_binding.dart';
import 'package:airmaster/screens/home/training_card/training/view/tc_training.dart';
import 'package:airmaster/screens/home/training_card/training/bindings/tc_training_binding.dart';
import 'package:airmaster/screens/home/training_card/training/view/new_training/view/new_training_view.dart';
import 'package:airmaster/screens/home/training_card/training/view/new_training/bindings/new_training_bindings.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/bindings/training_list_detail_bindings.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/training_list_detail_view.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/add_attendance/view/tc_add_attendance_view.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/add_attendance/bindings/tc_add_attendance_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.MAINTENANCE_SCREEN,
      page: () => const UnderMaintenance(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.MAIN_SCREEN,
      page: () => const HomeView(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.LOGIN_SCREEN,
      page: () => const LoginView(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TS1_MAIN,
      page: () => const TS1View(),
      binding: TS1_Main_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TS1_HOME_SCREEN,
      page: () => const TS1_Home(),
      binding: TS1_Home_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TS1_CANDIDATE_ASSESSMENT,
      page: () => const Candidate_View(),
      binding: Candidate_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TS1_FLIGHT_DETAILS,
      page: () => const FlightDetails_View(),
      binding: FlightDetails_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TS1_EVALUATION,
      page: () => const Evaluation_View(),
      binding: Evaluation_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TS1_OVERALL_PERFORMANCE,
      page: () => const Overall_Perform_View(),
      binding: Overall_Perform_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TS1_DECLARATION,
      page: () => const Declaration_View(),
      binding: Declaration_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.TS1_ANALYTICS,
      page: () => const TS1_Analytics(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TS1_HISTORY,
      page: () => const TS1_History(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TS1_PROFILE,
      page: () => const TS1_Profile(),
      binding: TS1_Profile_Binding(),
      transition: Transition.native,
    ),

    // Training Card
    GetPage(
      name: AppRoutes.TC_MAIN,
      page: () => const TCView(),
      binding: TC_Main_Binding(),
      transition: Transition.native,
    ),

    // TC Home Pilot Administrator
    GetPage(
      name: AppRoutes.TC_ADMINISTRATOR_HOME_SCREEN,
      page: () => const TC_Home_Administrator(),
      binding: TC_Home_Administrator_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_ATTENDANCE_DETAIL_NEEDCONFIRM,
      page: () => const TC_Attendance_Detail_Confirm(),
      binding: TC_AttendanceDetail_Confirm_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_ATTENDANCE_DETAIL_WAITING,
      page: () => const TC_Attendance_Detail_Pending(),
      binding: TC_AttendanceDetail_Pending_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.ADMIN_TOTAL_TRAINEE,
      page: () => const Ins_TotalTrainee(),
      binding: Ins_TotalTrainee_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_ABSENT_TRAINEE,
      page: () => const TC_AbsentParticipant(),
      binding: TC_AbsentParticipant_Binding(),
      transition: Transition.native,
    ),

    // TC Home Instructor
    GetPage(
      name: AppRoutes.TC_INSTRUCTOR_HOME,
      page: () => const TC_Home_Instructor(),
      binding: TC_Home_Instructor_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_INSTRUCTOR_ATTENDANCE_LIST,
      page: () => const TC_Ins_AttendanceList(),
      binding: TC_Ins_AttendanceList_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.INS_TOTAL_TRAINEE,
      page: () => const Ins_TotalTrainee(),
      binding: Ins_TotalTrainee_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.SCORING_TRAINEE,
      page: () => const Ins_ScoringTrainee(),
      binding: Ins_ScoringTrainee_Binding(),
      transition: Transition.native,
    ),

    // TC Home Examinee
    GetPage(
      name: AppRoutes.TC_EXAMINEE_HOME_SCREEN,
      page: () => const TC_Home_Examinee(),
      binding: TC_Home_Examinee_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_EXAMINEE_FEEDBACK_REQUIRED,
      page: () => const TC_FeedbackRequired(),
      binding: TC_FeedbackRequired_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_EXAMINEE_GIVE_FEEDBACK,
      page: () => const TC_ExamineeFeedback(),
      binding: TC_ExamineeFeedback_Binding(),
      transition: Transition.native,
    ),

    // TC Home CPTS
    GetPage(
      name: AppRoutes.TC_CPTS_HOME_SCREEN,
      page: () => const TC_Home_CPTS(),
      binding: TC_Home_CPTS_Binding(),
      transition: Transition.native,
    ),

    // TC Profile
    GetPage(
      name: AppRoutes.TC_PROFILE,
      page: () => const TC_Profile(),
      binding: TC_Profile_Binding(),
      transition: Transition.native,
    ),

    // TC Profile Examinee
    GetPage(
      name: AppRoutes.TC_PROFILE_EXAMINEE,
      page: () => const TC_ProfileExaminee(),
      binding: TC_ProfileExaminee_Binding(),
      transition: Transition.native,
    ),

    // TC Pilot Crew
    GetPage(
      name: AppRoutes.TC_PILOT_CREW,
      page: () => const TC_PilotCrew(),
      binding: TC_PilotCrew_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_PROFILE_PILOT,
      page: () => const TC_ProfilePilot(),
      binding: TC_ProfilePilot_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_PILOT_TRAINING_HISTORY,
      page: () => const TC_PilotTrainingHistory(),
      binding: TC_PilotTrainingHistory_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_DETAIL_PILOT_HISTORY,
      page: () => const TC_Detail_PilotHistory(),
      binding: TC_Detail_PilotHistory_Binding(),
      transition: Transition.native,
    ),

    //TC Training
    GetPage(
      name: AppRoutes.TC_TRAINING,
      page: () => const TC_Training(),
      binding: TC_Training_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_NEW_TRAINING,
      page: () => const TC_NewTraining(),
      binding: TC_NewTraining_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_TRAINING_LIST_DETAIL,
      page: () => const TC_TrainingListDetail(),
      binding: TC_TrainingListDetail_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_ADD_ATTENDANCE,
      page: () => TC_AddAttendance(),
      binding: TC_AddAttendance_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_ATTENDANCE_PENDING_DETAIL,
      page: () => const TC_Attendance_Detail_Pending(),
      binding: TC_AttendanceDetail_Pending_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_ATTENDANCE_CONFIRM_DETAIL,
      page: () => const TC_Attendance_Detail_Confirm(),
      binding: TC_AttendanceDetail_Confirm_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TC_ATTENDANCE_DONE_DETAIL,
      page: () => const TC_Attendance_Detail_Done(),
      binding: TC_AttendanceDetail_Done_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.DETAIL_ABSENT_TRAINEE,
      page: () => const TC_Detail_AbsentTrainee(),
      binding: TC_Detail_AbsentTrainee_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.TRAINING_HISTORY,
      page: () => const TC_TrainingHistory(),
      binding: TC_TrainingHistory_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.DETAIL_TRAINING_HISTORY,
      page: () => const TC_Detail_TrainingHistory(),
      binding: TC_Detail_TrainingHistory_Binding(),
      transition: Transition.native,
    ),

    //TC Training List Examinee
    GetPage(
      name: AppRoutes.EXAMINEE_TRAINING_LIST,
      page: () => const TC_TrainingList(),
      binding: TC_TrainingList_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.EXAMINEE_CREATE_ATTENDANCE,
      page: () => const Examinee_CreateAttendance(),
      binding: Examinee_CreateAttendance_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.EXAMINEE_ATTENDANCE_DETAIL,
      page: () => const Examinee_AttendanceDetail(),
      binding: Examinee_AttendanceDetail_Binding(),
      transition: Transition.native,
    ),

    // EFB
    GetPage(
      name: AppRoutes.EFB_MAIN,
      page: () => const EFBView(),
      binding: EFB_Main_Binding(),
      transition: Transition.native,
    ),

    // Home Pages
    GetPage(
      name: AppRoutes.EFB_HOME,
      page: () => const EFB_Home(),
      binding: EFB_Home_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_REQUEST,
      page: () => const Request_View(),
      binding: Request_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_ACCEPT_HANDOVER,
      page: () => const Accept_Handover_View(),
      binding: Accept_Handover_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_DETAIL,
      page: () => const Detail_View(),
      binding: Detail_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_FEEDBACK,
      page: () => const Feedback_View(),
      binding: Feedback_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_BATTERY,
      page: () => const Battery_View(),
      binding: Battery_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_CONFIRM,
      page: () => const Confirm_View(),
      binding: Confirm_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_HANDOVER,
      page: () => const Pilot_Handover_View(),
      binding: Pilot_Handover_Binding(),
      transition: Transition.native,
    ),

    // FO PAGES
    GetPage(
      name: AppRoutes.EFB_FO_REQUEST,
      page: () => const Fo_Request_View(),
      binding: Fo_Request_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_FO_WAITING_CONFIRMATION,
      page: () => const Fo_Waiting_View(),
      binding: Fo_Waiting_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_FO_IN_USE,
      page: () => const Fo_Used_View(),
      binding: Fo_Used_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_FO_FEEDBACK,
      page: () => const Fo_Feedback_View(),
      binding: Fo_Feedback_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_FO_BATTERY,
      page: () => const Fo_Battery_View(),
      binding: Fo_Battery_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_FO_CONFIRM,
      page: () => const Fo_Confirm_View(),
      binding: Fo_Confirm_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_FO_HANDOVER,
      page: () => const Fo_Handover_View(),
      binding: Fo_Handover_Binding(),
      transition: Transition.native,
    ),

    // OCC PAGES
    GetPage(
      name: AppRoutes.EFB_OCC_RETURN,
      page: () => const Occ_Return_View(),
      binding: Occ_Return_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_REQUESTED_TO_OCC,
      page: () => const OCC_Requested_View(),
      binding: OCC_Requested_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_USED_TO_OCC,
      page: () => const OCC_Used_View(),
      binding: OCC_Used_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_RETURNED_TO_OCC,
      page: () => const OCC_Returned_View(),
      binding: OCC_Returned_Binding(),
      transition: Transition.native,
    ),

    // Device Pages
    GetPage(
      name: AppRoutes.EFB_DEVICES,
      page: () => const EFB_Device(),
      binding: EFB_Device_Binding(),
      transition: Transition.native,
    ),

    // History Pages
    GetPage(
      name: AppRoutes.EFB_HISTORY,
      page: () => const EFB_History(),
      binding: EFB_History_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_HISTORY_DETAIL,
      page: () => const History_Detail_View(),
      binding: History_Detail_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_HISTORY_DETAIL_FEEDBACK,
      page: () => const Detail_Feedback_View(),
      binding: Detail_Feedback_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_FEEDBACK_FORMAT_PDF,
      page: () => const Format_Pdf_View(),
      binding: Format_Pdf_Binding(),
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoutes.EFB_HANDOVER_FORMAT_PDF,
      page: () => const Handover_Log_Format_View(),
      binding: Handover_Log_Format_Binding(),
      transition: Transition.native,
    ),

    // Analytics Pages
    GetPage(
      name: AppRoutes.EFB_ANALYTICS,
      page: () => const EFB_Analytics(),
      binding: EFB_Analytics_Binding(),
      transition: Transition.native,
    ),

    // Profile Pages
    GetPage(
      name: AppRoutes.EFB_PROFILE,
      page: () => const EFB_Profile(),
      binding: EFB_Profile_Binding(),
      transition: Transition.native,
    ),
  ];
}
