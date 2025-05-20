// ignore_for_file: constant_identifier_names

class ApiConfig {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const String loginUrl = '$baseUrl/login';
  static const String checkToken = '$baseUrl/check-token';

  static const String TS_1 = '$baseUrl/ts1';
  static const String get_user_by_name = '$TS_1/get-user-by-name';
  static const String get_flight_details = '$TS_1/get-flight-details';
}
