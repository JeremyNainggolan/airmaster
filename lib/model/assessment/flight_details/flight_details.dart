class FlightDetails {
  final List<String> flightDetails;

  FlightDetails({required this.flightDetails});

  factory FlightDetails.fromJson(Map<String, dynamic> response) {
    return FlightDetails(
      flightDetails: List<String>.from(
        response['flight_details'].map((x) => x),
      ),
    );
  }
}
