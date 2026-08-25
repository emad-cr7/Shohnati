import 'package:country_picker/country_picker.dart';

class Validators {
  // Required
  static String? required(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }

    return null;
  }

  // Name
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }

    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }

    return null;
  }

  // Store Name
  static String? storeName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your store name';
    }

    if (value.trim().length < 2) {
      return 'Store name must be at least 2 characters';
    }

    return null;
  }

  // Mobile
  static String? phone(String? value, Country country) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your Phone number';
    }

    final trimmedValue = value.trim();
    // لو الدولة مصر، سيب نفس الريجيكس بتاعك
    if (country.countryCode == 'EG') {
      if (!RegExp(r'^(01)[0-9]{9}$').hasMatch(trimmedValue)) {
        return 'Please enter a valid Egyptian Phone number';
      }
      return null;
    }

    // لأي دولة تانية: تحقق من الطول بس بناءً على مثال الباكدج
    final expectedLength = country.example.length;
    if (trimmedValue.length != expectedLength) {
      return 'Please enter a valid Phone number for ${country.name}';
    }

    return null;
  }

  // City
  static String? city(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your city';
    }

    return null;
  }

  // Area
  static String? area(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your area';
    }

    return null;
  }

  // Postal Code
  static String? postalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your postal code';
    }

    if (!RegExp(r'^[0-9]{5}$').hasMatch(value.trim())) {
      return 'Please enter a valid postal code';
    }

    return null;
  }

  // Address
  static String? address(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your address';
    }

    if (value.trim().length < 5) {
      return 'Address must be at least 5 characters';
    }

    return null;
  }

  // Password
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  // Confirm Password
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Email
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }

    return null;
  }
}
