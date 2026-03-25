import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.loginEntity});
  final LoginEntity loginEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
       
        String firstName = loginEntity.firstName;
        String lastName = loginEntity.lastName;
        String cityName = loginEntity.cityName;
        
        if (state is ProfileSuccess) {
          firstName = state.profileEntity.firstName;
          lastName = state.profileEntity.lastName;
          cityName = state.profileEntity.location;
        }
        
        final String fullName = '$firstName $lastName'.trim();
      
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome,',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  fullName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF888888),
                  ),
                ),
                if (cityName.isNotEmpty)
                  Text(
                    cityName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}