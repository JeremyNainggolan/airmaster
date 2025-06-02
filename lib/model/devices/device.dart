class Device {
  final String deviceNo;
  final String hub;
  final String docuVersion;
  final String iosVersion;
  final String flySmart;
  final String lidoVersion;
  final bool status;

  Device({
    required this.deviceNo,
    required this.hub,
    required this.docuVersion,
    required this.iosVersion,
    required this.flySmart,
    required this.lidoVersion,
    required this.status,
  });

  factory Device.fromJson(Map<String, dynamic> response) {
    return Device(
      deviceNo: response['deviceno'] ?? '',
      hub: response['hub'] ?? '',
      docuVersion: response['docuversion'] ?? '',
      iosVersion: response['iosver'] ?? '',
      flySmart: response['flysmart'] ?? '',
      lidoVersion: response['lidoversion'] ?? '',
      status: response['status'] ?? true,
    );
  }

  static List<Device> resultSearchJson(List<dynamic> response) {
    return response.map((item) => Device.fromJson(item)).toList();
  }
}
