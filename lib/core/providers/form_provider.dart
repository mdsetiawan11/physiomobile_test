import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  String? _fullName;
  String? _email;
  String? _errorMessage;

  String? get fullName => _fullName;
  String? get email => _email;
  String? get errorMessage => _errorMessage;

  // Set data when submit is pressed
  void submitForm(String fullName, String email) {
    _fullName = fullName;
    _email = email;
    _errorMessage = null; // Clear any previous error
    notifyListeners();
  }

  // Validate form fields
  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void resetForm() {
    _fullName = null;
    _email = null;
    _errorMessage = null;
    notifyListeners();
  }
}
