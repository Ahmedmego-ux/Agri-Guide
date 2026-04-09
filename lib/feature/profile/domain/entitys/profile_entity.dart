class ProfileEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String location;
  final double? lat;
  final double? lon;

  ProfileEntity( {
    required this.lat,
    required this.lon,  
    required this.id, 
    required this.firstName, 
  required this.lastName,
   required this.email,
    required this.location});


    
}