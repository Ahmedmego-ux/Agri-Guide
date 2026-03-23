import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
   HomeHeader({super.key, required this.loginEntity});
 final LoginEntity loginEntity;

  @override
  Widget build(BuildContext context) {
     print('=== HomeHeader Debug ===');
    print('firstName: ${loginEntity.firstName}');
    print('lastName: ${loginEntity.lastName}');
    print('cityName: ${loginEntity.cityName}');
    print('email: ${loginEntity.email}');
     final String fullName = '${loginEntity.firstName} ${loginEntity.lastName}'.trim();
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
             fullName ,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF888888),
              ),
            ),
          ],
        ),
       
      ],
    );
  }
}