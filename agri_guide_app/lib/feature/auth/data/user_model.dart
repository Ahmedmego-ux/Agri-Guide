class UserModel {
final String name;
final String Email;

final String? image;
final String?Visa;
final String?Address;
final String? token;

  UserModel({required this.name, required this.Email,  this.image,  this.Visa,  this.Address,  this.token});

factory UserModel.fromJson(Map<String,dynamic>json){
  return UserModel(
    name: json['name']??'',
   Email: json['email']??'',
    token: json['token']??'',
    image: json['image']??'',
     Visa: json['Visa']??'',
     Address: json['address']??'',
    
    );
}

}