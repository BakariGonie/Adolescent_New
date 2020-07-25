import 'package:email_validator/email_validator.dart';

class NameValidator {
  static String validate(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    if (!regExp.hasMatch(value)) {
      return 'Username must be a-z and A-Z';
    }

    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    if (!regExp.hasMatch(value)) {
      return 'Invalid email';
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }
}

class ComfirmPasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Confirm password is required';
    } else if (value.length < 6) {
      return 'Confirm password must be at least 6 characters';
    }
    return null;
  }
}

class MobileValidator {
  static String validate(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value
        .replaceAll(" ", "")
        .isEmpty) {
      return 'Mobile is required';
    } else if (value
        .replaceAll(" ", "")
        .length != 10) {
      return 'Mobile number must 10 digits';
    } else if (!regExp.hasMatch(value.replaceAll(" ", ""))) {
      return 'Mobile number must be digits';
    }
    return null;
  }
}