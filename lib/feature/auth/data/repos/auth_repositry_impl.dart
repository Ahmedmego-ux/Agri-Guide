

import 'package:agri_guide_app/feature/auth/data/models/singup_model.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/singup_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthRepositoryImpl implements AuthRepo {
  final SupabaseClient supabase;

  AuthRepositoryImpl(this.supabase);

  // @override
  // Future<void> login(LoginEntity loginEntity) async {
  //   await supabase.auth.signInWithPassword(
  //     email: loginEntity.email,
  //     password: loginEntity.password,
  //   );
  // }
 @override
  Future<void> Singup({required SingupEntity singupEntity}) async {
    final model = SignUpModel.fromSingUpEntity(singupEntity);
    if (!singupEntity.email.trim().endsWith('@gmail.com')) {
    throw Exception('You can only sign up with a Gmail account');
  }

    final response = await supabase.auth.signUp(
      email: model.email,
      password: model.password,
    );

    final user = response.user;

    if (user == null) {
      throw Exception("User creation failed");
    }

    await supabase.from('profiles').insert(model.toJson(user.id));
  }
  
 
}

