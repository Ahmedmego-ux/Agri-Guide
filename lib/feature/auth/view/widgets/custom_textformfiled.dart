import 'package:flutter/material.dart';

class CustomeTextFormField extends StatelessWidget {
  const CustomeTextFormField({
    super.key, 
    required this.hintText, 
    required this.controller, 
    this.suffixIcon,  
    required this.isPassword, 
    this.prefixIcon,
    this.bordercolor, 
    required this.labelText,
    this.validator, this.keyboardType, // أضفنا validator كـ parameter
  });

  final String hintText;
  final String labelText;
  final IconButton? suffixIcon;
  final Icon? prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final Color? bordercolor;
  final String? Function(String?)? validator; // نوع الـ validator
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            labelText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
              fontFamily: 'Poppins',
            ),
          ),
        ),
        
        // TextFormField
        TextFormField(
          validator: validator ?? (value) { // استخدام validator لو مديتهولوا
            if (value == null || value.isEmpty) {
              return 'Please enter your $labelText'; // رسالة أحسن
            }
            return null; // هنا كانت المشكلة الرئيسية
          },
          keyboardType: keyboardType,
          obscureText: isPassword,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
            
            // الـ hint (داخل الحقل)
            hintStyle: TextStyle(
              color: Colors.grey[400], // خفينا اللون شوية
              fontSize: 14,
            ),
            hintText: hintText,
            
            // الـ border في الحالات المختلفة
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // 12 في كل الحالات
            ),
            
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 1.5, // خففنا السمك شوية
                color: bordercolor ?? Colors.grey.shade300,
              ),
            ),
            
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.green, // أخضر ثابت مش بوردير كولور
                width: 2,
              ),
            ),
            
            // أضفنا error borders
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}