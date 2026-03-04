class LoginModel {
final String email;
final String password;
final double latitude;
  final double longitude;

  LoginModel(this.latitude, this.longitude, {required this.email, required this.password});
Map<String, dynamic> toJson(String userId) {
    return {
      'id': userId,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

}