import 'package:flutter/material.dart';

class Custome_Textformfield extends StatelessWidget {
  const Custome_Textformfield({
    super.key, required this.hintText,   required this.controller, this.suffixicon,  required this.ispassword, this.prefixicon, this.bordercolor

  });
final String hintText;
final IconButton? suffixicon;
final Icon? prefixicon;
final TextEditingController controller;
final bool ispassword;
final Color? bordercolor;
  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      
      validator: (value) {
        if(value==null||value.isEmpty){
          return 'please fill ${hintText}';
        }null;
      },
      obscureText: ispassword,
      controller: controller,
     decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      prefixIcon: prefixicon,
       filled: true,
       fillColor: Colors.white,
       suffixIcon: suffixicon,
       hintStyle: TextStyle(color: Colors.black),
       hintText: hintText,
       focusColor: Colors.white,
       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
       enabledBorder: OutlineInputBorder(
         borderSide: BorderSide(
          width: 2,
           color:bordercolor?? Colors.white
         ) 
       ),
       focusedBorder: OutlineInputBorder(
         borderSide: BorderSide(
           color: Colors.white
         ) 
     ),
            
    ));
  }
}