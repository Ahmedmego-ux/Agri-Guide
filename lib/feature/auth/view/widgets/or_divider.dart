import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: const [
          Expanded(child: Divider()),
      
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("OR"),
          ),
      
          Expanded(child: Divider()),
        ],
      ),
    );
  }
}