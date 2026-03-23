import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/feature/auth/data/repos/auth_repositry_impl.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/singup_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/repos/auth_repo.dart';

import 'package:agri_guide_app/feature/home/presentation/view/home_view.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sing_up_state.dart';

class SingUpCubit extends Cubit<SingUpState> {
  SingUpCubit() : super(SingUpInitial());
  
  final AuthRepo authRepo = AuthRepositoryImpl(Supabase.instance.client);
  
  // ✅ غيرت الاسم لـ signup (بحرف صغير)
  Future<void> signup(SingupEntity singupEntity, BuildContext context) async {
    emit(SingUpLoading());
    
    try {
      await authRepo.singup(singupEntity: singupEntity);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeView()),
        );
      }
      
      emit(SingUpSuccess());
    } catch (e) {
         print('🔴 Error: $e');
      emit(SingUpFailure(errmessage: ErrorHandler.handleAuthError(e)));
    }
  }



//   Future<void>SingupWithGoogle(BuildContext context,{required SingupEntity singupEntity})async{
    
//      emit(SingUpLoading());
//     try {
// await  authRepo.SingupWithGoogle();
// await  authRepo.createProfileFromGoogle(singupEntity: singupEntity);
  
//   ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Account created successfully')),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const Root()),
//         );
//         emit(SingUpSuccess());
// }  catch (e) {
//    print('🔴 Error: $e');
//    emit(SingUpFailure(errmessage: ErrorHandler.handleAuthError(e)));
// }

//   }
}