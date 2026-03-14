class LoginEntity {
  final String email;
  final String password;
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? cityName;

  LoginEntity({
    required this.email,
    required this.password,
    this.id,
    this.firstName,
    this.lastName,
    this.cityName,
  });
  }