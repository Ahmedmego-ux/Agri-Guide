class SingupEntity {
  final String firstName;
  final String lastName;
  final String password;
  final String email;

  final double latitude;
  final double longitude;

  SingupEntity({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
    required this.latitude,
    required this.longitude,
  });
}
