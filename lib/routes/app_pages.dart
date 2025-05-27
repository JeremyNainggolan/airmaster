// ignore_for_file: constant_identifier_names

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/auth/login.dart';
import 'package:airmaster/screens/home/dashboard.dart';
import 'package:airmaster/screens/home/efb/analytics/bindings/efb_analytics_binding.dart';
import 'package:airmaster/screens/home/efb/analytics/view/efb_analytics.dart';
import 'package:airmaster/screens/home/efb/devices/bindings/efb_device_binding.dart';
import 'package:airmaster/screens/home/efb/devices/view/efb_device.dart';
import 'package:airmaster/screens/home/efb/history/bindings/efb_history_binding.dart';
import 'package:airmaster/screens/home/efb/history/view/efb_history.dart';
import 'package:airmaster/screens/home/efb/home/bindings/efb_home_binding.dart';
import 'package:airmaster/screens/home/efb/home/view/efb_home.dart';
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
import 'package:get/get.dart';

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

    // GetPage(name: AppRoutes.TC_HOME, page: () => const TCView()),
    GetPage(
      name: AppRoutes.EFB_MAIN,
      page: () => const EFBView(),
      binding: EFB_Main_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.EFB_HOME,
      page: () => const EFB_Home(),
      binding: EFB_Home_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.EFB_DEVICES,
      page: () => const EFB_Device(),
      binding: EFB_Device_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.EFB_HISTORY,
      page: () => const EFB_History(),
      binding: EFB_History_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.EFB_ANALYTICS,
      page: () => const EFB_Analytics(),
      binding: EFB_Analytics_Binding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.EFB_PROFILE,
      page: () => const EFB_Profile(),
      binding: EFB_Profile_Binding(),
      transition: Transition.native,
    ),
  ];
}
