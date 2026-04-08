class LoginEntity {
  final String email;
  final String password;
  final String id;
  final String firstName;
  final String lastName;
  final String cityName;
  final double latitude;
 final double longitude;

  LoginEntity(
     {
    this.id = '',          
    required this.email,
    required this.password,
    this.firstName = '',    
    this.lastName = '',   
    this.cityName = '',
    this.latitude=0,
     this.longitude=0,
  });
  }