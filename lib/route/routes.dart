// routes.dart
import 'package:flutter/material.dart';
import 'package:sistem_pakar/main.dart';
import 'package:sistem_pakar/page/diagnosis_page.dart';
import 'package:sistem_pakar/page/login.dart';

class Routes {
  static const String login = '/login';
  static const String history = '/history';
  static const String Splash = '/splash';
  static const String diagnosis = '/diagnosis';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case diagnosis: // Tambahkan case untuk diagnosis
        return MaterialPageRoute(builder: (_) => DiagnosisPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
