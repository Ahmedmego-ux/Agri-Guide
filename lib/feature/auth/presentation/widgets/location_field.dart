import 'package:agri_guide_app/feature/auth/presentation/widgets/custom_textformfiled.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocationField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onTap;
 
  const LocationField({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomeTextFormField(
      hintText: 'Your location'.tr(),
      labelText: 'Location'.tr(),
      prefixIcon: const Icon(Icons.location_on),
      suffixIcon: IconButton(
        onPressed: isLoading ? null : onTap,
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.my_location, color: Colors.green),
      ),
      controller: controller,
      readOnly: true,
      validator: (v) => null,
      isPassword: false,
    );
  }
}
