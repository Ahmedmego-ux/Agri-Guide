import 'package:flutter/material.dart';

class CustomeProfileTextField extends StatelessWidget {
  const CustomeProfileTextField({
    super.key, required this.labeltext,  this.ispassword,
  });
final String labeltext;
//final String hinttext;
final bool? ispassword;


  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      cursorWidth: 3,
      style: TextStyle(color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600
      ),
      obscureText:ispassword?? false,
      decoration: InputDecoration(
        
        contentPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
      //  hintText: hinttext,
        hintStyle: TextStyle(color: Colors.white,
        fontSize: 20,fontWeight: FontWeight.w600
    
        ),
        
        labelText: labeltext, 
    labelStyle: TextStyle(
      color: Colors.white,
     fontWeight: FontWeight.w600,
     fontSize: 25
         ),
       floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
    borderSide: BorderSide(
                     color: Colors.grey,
        width: 1.2,
        ),),
        
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: Colors.white),
          borderRadius: BorderRadius.circular(18)
        ),
        focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(
            width: 1.5,
            color: Colors.white),
          borderRadius: BorderRadius.circular(18)
        )
      ),
    );
  }
}