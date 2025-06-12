abstract class Validator {
  static String? validateFullName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Full name is required.';
    }
    if (name.length < 2) {
      return 'Full name must be at least 2 characters long.';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (email == null || email.isEmpty) {
      return 'Email is required.';
    }
    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required.';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    final passwordRegex =
        RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$');
    if (!passwordRegex.hasMatch(password)) {
      return 'Password must include uppercase, lowercase, number, and special character.';
    }
    return null;
  }
}
