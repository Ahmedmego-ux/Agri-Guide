import 'package:agri_guide_app/core/constans/app_colors.dart';
import 'package:flutter/material.dart';



class Custome_auth_buttom extends StatelessWidget {
  const Custome_auth_buttom.CustomeButtom({
    super.key, required this.progres, this.color, this.colortext,
  });
  final Color? color;
  final Color? colortext;
final String progres;
  @override
  Widget build(BuildContext context) {
    return Container(
     height: MediaQuery.heightOf(context)*0.07,
     width: double.infinity,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(8),
       color: color??Colors.white
     ),
     child: Center(child: Text(progres,style: TextStyle(fontSize: 20,color:colortext?? maincolor,fontFamily: 'Poppins' ),)),
    );
  }
}

