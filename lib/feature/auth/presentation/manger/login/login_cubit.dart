import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/feature/auth/data/repos/auth_repositry_impl.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';



import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final authRepo =AuthRepositoryImpl(Supabase.instance.client);

Future<void> login( {required LoginEntity userData, required BuildContext context})async{
  emit(LoginLoading());
try {

  final response=  await authRepo.login(loginEntity: userData);
 
   

  emit(LoginSuccess(userData: response));

}  catch (e) {
  print('🔴 Error: $e');
 emit(LoginFailure(errmessage:ErrorHandler.handleAuthError(e) ));
}

}

}
