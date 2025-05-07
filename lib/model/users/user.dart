class User {
  bool? isLogin;
  String? token;
  String? token_type;
  String? id_number;
  String? name;
  String? email;
  String? hub;
  String? status;
  String? loa_number;
  String? license_number;
  DateTime? license_expiry;
  String? rank;
  List<String>? instructor;

  User({
    this.isLogin,
    this.token,
    this.token_type,
    this.id_number,
    this.name,
    this.email,
    this.hub,
    this.status,
    this.loa_number,
    this.license_number,
    this.license_expiry,
    this.rank,
    this.instructor,
  });

  factory User.fromJson(Map<String, dynamic> response) {
    return User(
      isLogin: true,
      token: response['token'],
      token_type: response['token_type'],
      id_number: response['id_number'],
      name: response['name'],
      email: response['email'],
      hub: response['hub'],
      status: response['status'],
      loa_number: response['loa_number'],
      license_number: response['license_number'],
      license_expiry:
          response['license_expiry'] != null &&
                  response['license_expiry'] != "object"
              ? DateTime.tryParse(response['license_expiry'])
              : null,
      rank: response['rank'],
      instructor:
          response['instructor'] != null
              ? List<String>.from(response['instructor'].map((x) => x))
              : [],
    );
  }
}
