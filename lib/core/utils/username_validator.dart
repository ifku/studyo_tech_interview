class UsernameValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Username cannot be empty";
    } else if (value.length < 8) {
      return "Minimum 8 characters";
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return "Use characters and numbers only";
    } else {
      return null;
    }
  }
}
