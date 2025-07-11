// ignore_for_file: constant_identifier_names

class ApiConfig {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const String loginUrl = '$baseUrl/login';
  static const String checkToken = '$baseUrl/check-token';

  static const String TS_1 = '$baseUrl/ts1';
  static const String get_user_by_name = '$TS_1/get-user-by-name';
  static const String get_flight_details = '$TS_1/get-flight-details';


  // Administration API Endpoints
  static const String TC = '$baseUrl/tc';
  static const String get_training_cards = '$TC/get-training-cards';
  static const String new_training_card = '$TC/new-training-card';
  static const String get_att_instructor = '$TC/get-att-instructor';
  static const String new_training_attendance = '$TC/new-training-attendance';
  static const String get_attendance_list = '$TC/get-attendance-list';
  static const String delete_training_card = '$TC/delete-training-card';
  

  //home administrator
  static const String get_total_participant_confirm = '$TC/get-total-participant';
  static const String get_pilot_list = '$TC/get-pilot-list';
  static const String confirm_class_attendance = '$TC/confirm-class-attendance';
  static const String recurrent_date_training = '$TC/recurrent-date-training';
  
  static const String get_total_participant_done = '$TC/get-total-participant';
  static const String get_absent_participant = '$TC/get-absent-participant';
  static const String get_total_absent_trainee = '$TC/get-total-absent-trainee';
    static const String get_training_list = '$TC/get-training-cards';

  //home tc
  static const String get_status_confirmation = '$TC/get-status-confirmation';

  //home instructor
  static const String get_training_overview = '$TC/get-training-overview';
  static const String confirm_attendance ='$TC/confirm-attendance';
  static const String get_attendance = '$TC/get-attendance';
  static const String get_trainee_details = '$TC/get-trainee-details';
  static const String trainee_details = '$TC/trainee-details';
  static const String save_trainee_score = '$TC/save-trainee-score';

  // home examinee
  static const String get_need_feedback = '$TC/get-need-feedback';
  static const String get_att_trainees = '$TC/get-att-trainees';
  static const String get_class_open = '$TC/get-class-open';
  static const String check_class_password = '$TC/check-class-password';

  static const String create_attendance_detail =
      '$TC/create-attendance-detail';


  static const String EFB = '$baseUrl/efb';

  /*
    |--------------------------------------------------------------------------
    | Line 29 - 45 EFB HOME API ENDPOINTS
    |--------------------------------------------------------------------------
    |
    | These endpoints are used for the EFB home screen functionalities.
    |
    */

  static const String get_count_devices = '$EFB/get-count-devices';
  static const String get_user_by_id = '$EFB/get-user-by-id';
  static const String get_devices = '$EFB/get-devices';
  static const String get_pilot_devices = '$EFB/get-pilot-devices';
  static const String get_device_by_id = '$EFB/get-device-by-id';
  static const String get_device_by_name = '$EFB/get-device-by-name';
  static const String get_confirmation_status = '$EFB/get-confirmation-status';
  static const String get_handover_device = '$EFB/get-handover-device';
  static const String get_handover_device_detail =
      '$EFB/get-handover-device-detail';
  static const String check_request = '$EFB/check-request';
  static const String fo_submit_request = '$EFB/fo-submit-request';
  static const String submit_request = '$EFB/submit-request';
  static const String cancel_request = '$EFB/cancel-request';
  static const String pilot_handover = '$EFB/pilot-handover';
  static const String confirm_pilot_handover = '$EFB/confirm-pilot-handover';
  static const String occ_return = '$EFB/occ-return';

  static const String get_confirmation_occ = '$EFB/get-confirmation-occ';
  static const String reject_request_device = '$EFB/reject-request-device';
  static const String approve_request_device = '$EFB/approve-request-device';
  static const String confirm_return = '$EFB/confirm-return';

  /*
    |--------------------------------------------------------------------------
    | Line 56 - .. EFB HISTORY API ENDPOINTS
    |--------------------------------------------------------------------------
    |
    | These endpoints are used for the EFB home screen functionalities.
    |
    */

  static const String get_history = '$EFB/get-history-occ';
  static const String get_other_history = '$EFB/get-history-other';
  static const String get_device_image = '$EFB/get-device-image';
  static const String get_signature_image = '$EFB/get-signature-image';
  static const String get_feedback_detail = '$EFB/get-feedback-detail';
  static const String get_format_pdf = '$EFB/get-format-pdf';
  static const String update_format_pdf = '$EFB/update-format-pdf';

  /*
    |--------------------------------------------------------------------------
    | Line 83 - .. EFB ANALYTICS API ENDPOINTS
    |--------------------------------------------------------------------------
    |
    | These endpoints are used for the EFB analytics screen functionalities.
    |
    */

  static const String get_hub = '$EFB/get-hub';
  static const String get_count_hub = '$EFB/get-count-hub';
  static const String get_all_pilot_devices = '$EFB/get-all-pilot-devices';
}
