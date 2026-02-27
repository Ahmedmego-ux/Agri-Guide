import 'package:agri_guide_app/core/constans/app_colors.dart';

import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key, 
    required this.text, 
    this.backgroundColor, 
    this.textColor, 
    this.borderColor,
    this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        height: 55, // Height ثابت أفضل من MediaQuery
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? (onPressed == null ? Colors.grey.shade300 : backgroundColor ?? maincolor),
            width: borderColor != null ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12), // 12 بدل 8 عشان يكون متناسق
          color: isLoading 
              ? Colors.grey.shade300 
              : (backgroundColor ?? (onPressed == null ? Colors.grey.shade200 : maincolor)),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: 16, // 16 أنسب من 20
                    fontWeight: FontWeight.w600,
                    color: isLoading 
                        ? Colors.grey.shade600
                        : (textColor ?? (onPressed == null ? Colors.grey.shade600 : Colors.white)),
                    fontFamily: 'Poppins',
                  ),
                ),
        ),
      ),
    );
  }
}
