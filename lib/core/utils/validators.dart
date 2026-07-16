import '../constant/app_strings.dart';

/// Pure form validators for the contact form. No UI, easily unit-tested.
class Validators {
  const Validators._();

  static final RegExp _email = RegExp(
    r'^[\w.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9.-]+$',
  );

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.nameRequired;
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.emailRequired;
    if (!_email.hasMatch(value.trim())) return AppStrings.emailInvalid;
    return null;
  }

  static String? message(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.messageRequired;
    }
    return null;
  }
}