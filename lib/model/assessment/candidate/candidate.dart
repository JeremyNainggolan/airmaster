// ignore_for_file: non_constant_identifier_names

class Candidate {
  String firstFlightCrewName;
  String firstFlightCrewStaffNumber;
  String firstFlightCrewLicense;
  String firstFlightCrewLicenseExpiry;

  String secondFlightCrewName;
  String secondFlightCrewStaffNumber;
  String secondFlightCrewLicense;
  String secondFlightCrewLicenseExpiry;

  String aircraftType;
  String airportAndRoute;
  String simulationHours;
  String simulationIdentity;
  String loaNumber;

  Candidate({
    required this.firstFlightCrewName,
    required this.firstFlightCrewStaffNumber,
    required this.firstFlightCrewLicense,
    required this.firstFlightCrewLicenseExpiry,
    required this.secondFlightCrewName,
    required this.secondFlightCrewStaffNumber,
    required this.secondFlightCrewLicense,
    required this.secondFlightCrewLicenseExpiry,
    required this.aircraftType,
    required this.airportAndRoute,
    required this.simulationHours,
    required this.simulationIdentity,
    required this.loaNumber,
  });
}
