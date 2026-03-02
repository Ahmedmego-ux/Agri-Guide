import 'package:agri_guide_app/core/constans/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
             child: CircleAvatar(
               
               radius: 40,
               backgroundColor: Colors.green,
               child: SvgPicture.asset(
                 'assets/logo.svg',
                 color: Colors.white,
                 height: 45,
               ),
             ),
           ),
            SizedBox(height:15,),
        
           Center(
             child: Text(
                       'Agri Guide',
                       style: TextStyle(
                         fontSize: 25,
                         color: const Color.fromARGB(199, 0, 0, 0),
                         fontFamily: fontFamily,
                       ),
                     ),
           ),
      ],
    );
  }
}