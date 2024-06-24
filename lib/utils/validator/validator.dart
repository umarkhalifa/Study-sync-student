class AppValidator {


  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.length < 8) {
      return "Password must be at least 8 characters long";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.contains("@") == false) {
      return "Enter a valid email";
    }
    return null;
  }

  String? validateMatric(String? value) {
    if (value == null || value.length < 10) {
      return 'Please enter a valid matric Number';
    }
    return null;
  }
}
