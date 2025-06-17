import 'dart:io';
import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  String username = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
  String address = '';
  String pricePerHour = '';
  File? profileImage;

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

  void updatePricePerHour(String value) {
    pricePerHour = value;
    notifyListeners();
  }

  void updateProfileImage(File newImage) {
    profileImage = newImage;
    notifyListeners();
  }

  void setAllUserData({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
    required String address,
    String? pricePerHour,
    File? profileImage,
  }) {
    this.username = username;
    this.email = email;
    this.phoneNumber = phoneNumber;
    this.password = password;
    this.address = address;
    if (pricePerHour != null) this.pricePerHour = pricePerHour;
    if (profileImage != null) this.profileImage = profileImage;
    notifyListeners();
  }
}
