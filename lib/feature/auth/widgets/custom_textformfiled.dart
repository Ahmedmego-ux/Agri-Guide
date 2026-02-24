import 'package:flutter/material.dart';

class Custome_Textformfield extends StatelessWidget {
  const Custome_Textformfield({
    super.key, required this.hintText, 
      required this.controller, this.suffixicon,  
      required this.ispassword, this.prefixicon,
       this.bordercolor, required this.lableText

  });
final String hintText;
final String lableText;
final IconButton? suffixicon;
final Icon? prefixicon;
final TextEditingController controller;
final bool ispassword;
final Color? bordercolor;
  @override
  Widget build(BuildContext context) {
    
    return Column(
    
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            lableText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
              fontFamily: 'Poppins', // أو استخدم الخط اللي عندك
            ),
          ),
        ),
        TextFormField(
          
          validator: (value) {
            if(value==null||value.isEmpty){
              return 'please fill ${hintText}';
            }null;
          },
        
          obscureText: ispassword,
          controller: controller,
         decoration: InputDecoration(
          // labelStyle: TextStyle(color: Colors.black),
          // labelText: lableText,
          
          //contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          prefixIcon: prefixicon,
           filled: true,
           fillColor: Colors.white,
           suffixIcon: suffixicon,
           hintStyle: TextStyle(color: Colors.black),
           hintText: hintText,
           focusColor: Colors.white,
           border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16)),
           
           enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
             borderSide: BorderSide(
              width: 2,
               color:bordercolor?? const Color.fromARGB(255, 227, 225, 225)
             ) 
           ),
           focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8),
             borderSide: BorderSide(
               color: bordercolor?? Colors.grey
             ) 
         ),
                
        )),
      ],
    );
  }
}