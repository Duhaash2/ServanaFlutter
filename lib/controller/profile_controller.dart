import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  String username = "Ahmad Daboor";
  String email = "Loisbecket@gmail.com";
  String phoneNumber = "0797653948";
  String password = "***************";
  String address = "123 Al-Madina Street, Abdali,...";

  bool isValidName(String name) => name.isNotEmpty;
  bool isValidEmail(String email) => email.contains('@') && email.contains('.');
  bool isValidPassword(String password) => password.length >= 6;

  void updateUsername(String value) {
    username = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void updateAddress(String value) {
    address = value;
    notifyListeners();
  }
}