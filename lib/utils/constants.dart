import 'package:flutter/material.dart';

class Routes {
  static const String splashScreen = "/splashScreen";
  static const String home = "/home";
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String wrapper = '/wrapper';
  static const String emailVerification = '/emailVerification';
  static const String settings = '/settings';
  static const String articleDetailsView = '/articleDetailsView';
}

InputDecoration inputDecoration = const InputDecoration(
    hintStyle: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
    border: InputBorder.none);
