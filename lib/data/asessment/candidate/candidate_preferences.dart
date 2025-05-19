import 'package:airmaster/model/assessment/candidate/candidate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CandidatePreferences {
  static final CandidatePreferences _instance =
      CandidatePreferences._internal();
  SharedPreferences? _prefs;

  CandidatePreferences._internal();

  factory CandidatePreferences() {
    return _instance;
  }

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<bool> saveCandidate(Candidate candidate) async {
    await init();
    await _prefs!.setString(
      'first_flight_crew_name',
      candidate.firstFlightCrewName,
    );
    await _prefs!.setString(
      'first_flight_crew_staff_number',
      candidate.firstFlightCrewStaffNumber,
    );
    await _prefs!.setString(
      'first_flight_crew_license',
      candidate.firstFlightCrewLicense,
    );
    await _prefs!.setString(
      'first_flight_crew_license_expiry',
      candidate.firstFlightCrewLicenseExpiry,
    );
    await _prefs!.setString(
      'second_flight_crew_name',
      candidate.secondFlightCrewName,
    );
    await _prefs!.setString(
      'second_flight_crew_staff_number',
      candidate.secondFlightCrewStaffNumber,
    );
    await _prefs!.setString(
      'second_flight_crew_license',
      candidate.secondFlightCrewLicense,
    );
    await _prefs!.setString(
      'second_flight_crew_license_expiry',
      candidate.secondFlightCrewLicenseExpiry,
    );
    await _prefs!.setString('aircraft_type', candidate.aircraftType);
    await _prefs!.setString('airport_and_route', candidate.airportAndRoute);
    await _prefs!.setString('simulation_hours', candidate.simulationHours);
    await _prefs!.setString(
      'simulation_identity',
      candidate.simulationIdentity,
    );
    await _prefs!.setString('loa_number', candidate.loaNumber);
    return true;
  }

  Future<Candidate> getCandidate() async {
    await init();
    return Candidate(
      firstFlightCrewName: _prefs!.getString('first_flight_crew_name') ?? '',
      firstFlightCrewStaffNumber:
          _prefs!.getString('first_flight_crew_staff_number') ?? '',
      firstFlightCrewLicense: _prefs!.getString('first_flight_license') ?? '',
      firstFlightCrewLicenseExpiry:
          _prefs!.getString('first_flight_crew_license_expiry') ?? '',
      secondFlightCrewName: _prefs!.getString('second_flight_crew_name') ?? '',
      secondFlightCrewStaffNumber:
          _prefs!.getString('second_flight_crew_staff_number') ?? '',
      secondFlightCrewLicense: _prefs!.getString('second_flight_license') ?? '',
      secondFlightCrewLicenseExpiry:
          _prefs!.getString('second_flight_crew_license_expiry') ?? '',
      aircraftType: _prefs!.getString('aircraft_type') ?? '',
      airportAndRoute: _prefs!.getString('airport_and_route') ?? '',
      simulationHours: _prefs!.getString('simulation_hours') ?? '',
      simulationIdentity: _prefs!.getString('simulation_identity') ?? '',
      loaNumber: _prefs!.getString('loa_number') ?? '',
    );
  }

  Future<void> clearCandidate() async {
    await init();
    await _prefs!.remove('first_flight_crew_name');
    await _prefs!.remove('first_flight_crew_staff_number');
    await _prefs!.remove('first_flight_license');
    await _prefs!.remove('first_flight_crew_license_expiry');
    await _prefs!.remove('second_flight_crew_name');
    await _prefs!.remove('second_flight_crew_staff_number');
    await _prefs!.remove('second_flight_license');
    await _prefs!.remove('second_flight_crew_license_expiry');
    await _prefs!.remove('aircraft_type');
    await _prefs!.remove('airport_and_route');
    await _prefs!.remove('simulation_hours');
    await _prefs!.remove('simulation_identity');
    await _prefs!.remove('loa_number');
  }
}
