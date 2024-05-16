class CustomValidator {
  static String? validateNormal(String? value) {
    if (value!.isEmpty) {
      return "Required *";
    }
    return null;
  }

  static String? validateNormalwithMSG(String? value, String? msg) {
    if (value!.isEmpty) {
      return '$msg';
    }
    return null;
  }

  static String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return "Enter Mobile Number";
    } else if (value.length > 10 || value.length < 10) {
      return "Enter a valid Mobile Number";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isNotEmpty) {
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
        return "Please Enter the Valid Email";
      }
    } else {
      return null;
    }
    return null;
  }
}
