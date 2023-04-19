import 'package:get/get.dart';

class Validators {
  static String? checkFieldEmpty(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }


  static String? checkPasswordField(String? fieldContent) {
    //hasUppercase
    RegExp exp1 = RegExp(r'[A-Z]');
    //hasDigits
    RegExp exp2 = RegExp(r'[0-9]');
    //hasLowercase
    RegExp exp3 = RegExp(r'[a-z]');
    //hasSpecialCharacters
    RegExp exp4 = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (fieldContent!.isEmpty) {
      return 'This field is required';
    } else if (fieldContent.length < 8) {
      return 'The password should be at least 8 digits';
    } else if (!exp1.hasMatch(fieldContent)) {
      return 'Password must contain at least one uppercase character';
    } else if (!exp2.hasMatch(fieldContent)) {
      return 'Password must contain at least one digits';
    } else if (!exp3.hasMatch(fieldContent)) {
      return 'Password must contain at least one lower character';
    } else if (!exp4.hasMatch(fieldContent)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  static String? checkEmailField(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'This field is required';
    } else if (!GetUtils.isEmail(fieldContent)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? checkOptionalEmailField(String? fieldContent) {
    if (fieldContent == null) return null;
    if (fieldContent.isEmpty) return null;
    if (!GetUtils.isEmail(fieldContent)) {
      return 'Invalid email address';
    }
    return null;
  }
}
