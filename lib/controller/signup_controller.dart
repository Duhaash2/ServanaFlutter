import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import '../../model/auth_model/signup_model.dart';
import '../../model/auth_model/reset_password_model.dart';
import '../core/const_values.dart';

class SignUpController extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // HTTP Client (ignoring SSL errors)
  http.Client createHttpClient() {
    final httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return IOClient(httpClient);
  }

  Future<bool> registerUser(SignUpModel user) async {
    setLoading(true);

    // ✅✅ تم تعليق كود تسجيل المستخدم مؤقتًا لتجربة الواجهة فقط بدون استدعاء API:
    /*
    try {
      final client = createHttpClient();
      final response = await client.post(
        Uri.parse('${ConstValue.baseUrl}api/Auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        setLoading(false);
        return true;
      } else {
        setErrorMessage('Registration failed: ${response.statusCode} - ${response.body}');
        setLoading(false);
        return false;
      }
    } catch (e) {
      setErrorMessage('Unexpected error: $e');
      setLoading(false);
      return false;
    }
    */

    setLoading(false);
    return true; // ✅ وهميًا لإكمال تجربة الواجهة بدون سيرفر
  }
}
