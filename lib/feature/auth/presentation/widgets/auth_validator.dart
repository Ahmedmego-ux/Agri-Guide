import 'package:easy_localization/easy_localization.dart';

class AuthValidators {
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'fieldCannotBeEmpty'.tr(args: [fieldName]);
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'emailCannotBeEmpty'.tr();
    }

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!regex.hasMatch(value)) {
      return 'invalidEmail'.tr();
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'passwordCannotBeEmpty'.tr();
    }

    if (value.length < 6) {
      return 'passwordTooShort'.tr();
    }

    return null;
  }
}