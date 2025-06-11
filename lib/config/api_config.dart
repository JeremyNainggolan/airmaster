// ignore_for_file: constant_identifier_names

class ApiConfig {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const String loginUrl = '$baseUrl/login';
  static const String checkToken = '$baseUrl/check-token';

  static const String TS_1 = '$baseUrl/ts1';
  static const String get_user_by_name = '$TS_1/get-user-by-name';
  static const String get_flight_details = '$TS_1/get-flight-details';

  static const String TC = '$baseUrl/tc';
  static const String get_training_cards = '$TC/index';
  static const String new_training_card = '$TC/store';

  static const String EFB = '$baseUrl/efb';
  static const String get_count_devices = '$EFB/get-count-devices';
  static const String get_user_by_id = '$EFB/get-user-by-id';
  static const String get_devices = '$EFB/get-devices';
  static const String get_pilot_devices = '$EFB/get-pilot-devices';
  static const String get_device_by_id = '$EFB/get-device-by-id';
  static const String get_device_by_name = '$EFB/get-device-by-name';
  static const String get_confirmation_status = '$EFB/get-confirmation-status';
  static const String check_request = '$EFB/check-request';
  static const String submit_request = '$EFB/submit-request';
  static const String cancel_request = '$EFB/cancel-request';
  static const String pilot_handover = '$EFB/pilot-handover';
  static const String occ_return = '$EFB/occ-return';
}
