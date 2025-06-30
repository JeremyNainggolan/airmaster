// ignore_for_file: constant_identifier_names

class AppRoutes {
  AppRoutes._();

  static const String MAINTENANCE_SCREEN = '/maintenance';

  static const String LOGIN_SCREEN = '/login';

  static const String MAIN_SCREEN = '/main';

  static const String TS1_MAIN = '/main/ts1';

  static const String TS1_HOME_SCREEN = '/main/ts1/home';
  static const String TS1_CANDIDATE_ASSESSMENT =
      '/main/ts1/assessment/candidate_assessment';
  static const String TS1_FLIGHT_DETAILS =
      '/main/ts1/assessment/flight_details';
  static const String TS1_EVALUATION = '/main/ts1/assessment/evaluation';
  static const String TS1_OVERALL_PERFORMANCE =
      '/main/ts1/assessment/overall_performance';
  static const String TS1_DECLARATION = '/main/ts1/assessment/declaration';

  static const String TS1_ANALYTICS = '/main/ts1/analytics';
  static const String TS1_HISTORY = '/main/ts1/history';
  static const String TS1_PROFILE = '/main/ts1/profile';

  static const String TC_MAIN = '/main/tc';

  static const String TC_HOME_SCREEN = '/main/tc/home';
  static const String TC_TRAINING = '/main/tc/training';
  static const String TC_NEW_TRAINING = '/main/tc/new_training';
  static const String TC_TRAINING_LIST_DETAIL = '/main/tc/training_list_detail';
  static const String TC_ADD_ATTENDANCE = '/main/tc/add_attendance';

  static const String TC_PILOT_CREW = '/main/tc/pilot_crew';
  static const String TC_PROFILE = '/main/tc/profile';

  static const String EFB_MAIN = '/main/efb';
  static const String EFB_HOME = '/main/efb/home';
  static const String EFB_REQUEST = '/main/efb/home/request';
  static const String EFB_DETAIL = '/main/efb/home/detail';
  static const String EFB_ACCEPT_HANDOVER = '/main/efb/home/accept-handover';
  static const String EFB_FEEDBACK = '/main/efb/home/detail/feedback';
  static const String EFB_BATTERY = '/main/efb/home/detail/battery';
  static const String EFB_CONFIRM = '/main/efb/home/detail/confirm';
  static const String EFB_HANDOVER = '/main/efb/home/detail/handover';
  static const String EFB_OCC_RETURN = '/main/efb/home/detail/occ-return';

  static const String EFB_FO_REQUEST = '/main/efb/home/fo/request';
  static const String EFB_FO_WAITING_CONFIRMATION =
      '/main/efb/home/fo/waiting-confirmation';
  static const String EFB_FO_IN_USE = '/main/efb/home/fo/in-use';
  static const String EFB_FO_FEEDBACK = '/main/efb/home/fo/in-use/feedback';
  static const String EFB_FO_BATTERY = '/main/efb/home/fo/in-use/battery';
  static const String EFB_FO_CONFIRM = '/main/efb/home/fo/in-use/confirm';
  static const String EFB_FO_HANDOVER = '/main/efb/home/fo/handover';

  static const String EFB_REQUESTED_TO_OCC = '/main/efb/home/requested-to-occ';
  static const String EFB_USED_TO_OCC = '/main/efb/home/used-to-occ';
  static const String EFB_RETURNED_TO_OCC = '/main/efb/home/returned-to-occ';

  static const String EFB_DEVICES = '/main/efb/devices';

  static const String EFB_HISTORY = '/main/efb/history';
  static const String EFB_HISTORY_DETAIL = '/main/efb/history/detail';
  static const String EFB_HISTORY_DETAIL_FEEDBACK =
      '/main/efb/history/detail/feedback';
  static const String EFB_FEEDBACK_FORMAT_PDF =
      '/main/efb/history/detail/feedback/format-pdf';
  static const String EFB_HANDOVER_FORMAT_PDF =
      '/main/efb/history/detail/handover/format-pdf';

  static const String EFB_ANALYTICS = '/main/efb/analytics';
  static const String EFB_PROFILE = '/main/efb/profile';
}
