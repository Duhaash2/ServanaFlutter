import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationController with ChangeNotifier {
  final List<RemoteMessage> _messages = [];

  List<RemoteMessage> get messages => _messages;

  void addMessage(RemoteMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
