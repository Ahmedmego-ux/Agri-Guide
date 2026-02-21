

import 'package:shared_preferences/shared_preferences.dart';

class PrefHelpers {

static const String _tokenKey='auth_token';
 
static Future<void>savetoken({required String token})async{
  final prefs=await SharedPreferences.getInstance();
 await prefs.setString(_tokenKey, token);
} 

static Future<String?>gettoken()async{
  final prefs=await SharedPreferences.getInstance();
return  prefs.getString(_tokenKey);
 
} 

static Future<void>cleartoken()async{
  final prefs=await SharedPreferences.getInstance();
 prefs.remove(_tokenKey);

} 

}