import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;
  String? _errorMessage;

  int get counter => _counter;
  String? get errorMessage => _errorMessage;

  void increment() {
    _counter++;
    _errorMessage = null;
    notifyListeners();
  }

  void decrement() {
    if (_counter > 0) {
      _counter--;
      _errorMessage = null;
    } else {
      _errorMessage = 'Cannot be less than 0';
    }
    notifyListeners();
  }

  void reset() {
    _counter = 0;
    _errorMessage = null;
    notifyListeners();
  }
}
