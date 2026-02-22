

import 'package:agri_guide_app/core/network/api_errors.dart';
import 'package:agri_guide_app/core/network/api_exceptions.dart';
import 'package:agri_guide_app/core/network/api_services.dart';
import 'package:agri_guide_app/core/utils/pref_helpers.dart';
import 'package:agri_guide_app/feature/auth/data/user_model.dart';
import 'package:dio/dio.dart';

class AuthRepo {


  AuthRepo();
  final ApiServices apiServices=ApiServices();

//login
Future<UserModel> login(String Email,String password)async{
try {

 final response= await apiServices.post('/login', 
  {'email':Email,'password':password});

  if(response is ApiErrors)throw response;
  if(response is Map<String,dynamic>){
    final msg=response['message'];
    final code=response['code'];
    final data=response['data'];
    if(code!=200||data==null){
      throw ApiErrors(message: msg);
    }
  
final user= UserModel.fromJson(response['data']);


if(user.token!=null){
  PrefHelpers.savetoken(token: user.token!);
}

return user;
    

  }else
  {
   throw ApiErrors(message: ' un exption ');
  }
} on DioException catch (e) {
throw ApiExceptions.handleError(e);
}catch(e){
 throw ApiErrors(message: e.toString());
}

}


}