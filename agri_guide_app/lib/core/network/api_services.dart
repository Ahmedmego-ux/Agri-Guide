import 'package:agri_guide_app/core/network/api_exceptions.dart';
import 'package:agri_guide_app/core/network/dio_client.dart';
import 'package:dio/dio.dart';


class ApiServices {

final DioClient _dioClient=DioClient();

//get
Future<dynamic> get(String endpoint)async{
  try {
  final response =await _dioClient.dio.get(endpoint);
  return response.data;
}on DioException  catch (e) {
  return ApiExceptions.handleError(e);
  
}

}

//post
Future<dynamic> post(String endpoint,Map<String,dynamic> data)async{
  try {
  final response =await _dioClient.dio.post(endpoint,data: data);
  return response.data;
}on DioException  catch (e) {
  return ApiExceptions.handleError(e);
  
}

}
//put
Future<dynamic> update(String endpoint,Map<String,dynamic> data)async{
  try {
  final response =await _dioClient.dio.put(endpoint,data:data );
  return response.data;
}on DioException  catch (e) {
  return ApiExceptions.handleError(e);
  
}

}

//delet
Future<dynamic> delet(String endpoint,Map<String,dynamic> data)async{
  try {
  final response =await _dioClient.dio.delete(endpoint,data:data );
  return response.data;
}on DioException  catch (e) {
  return ApiExceptions.handleError(e);
  
}

}




}