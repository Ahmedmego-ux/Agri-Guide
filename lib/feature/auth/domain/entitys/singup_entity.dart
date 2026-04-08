class SingupEntity {
  final String firstName;
  final String lastName;
  final String password;
  final String email;

  final String cityName;
  final double latitude;
 final double longitude;

  SingupEntity( {
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
    required this.cityName,
    required this.longitude,
    required this.latitude,
  
  });
}
