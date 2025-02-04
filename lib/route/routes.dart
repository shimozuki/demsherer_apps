import 'package:flutter/material.dart';
import 'package:sistem_pakar/main.dart';
import 'package:sistem_pakar/page/diagnosis_page.dart';
import 'package:sistem_pakar/page/hasil.dart';
import 'package:sistem_pakar/page/login.dart';

class Routes {
  static const String login = '/login';
  static const String history = '/history';
  static const String splash = '/splash';
  static const String diagnosis = '/diagnosis';
  static const String detailRiwayat =
      '/detailRiwayat'; // Tambahkan konstanta untuk detail riwayat

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case diagnosis:
        return MaterialPageRoute(builder: (_) => DiagnosisPage());
      case detailRiwayat:
        final args =
            settings.arguments as Map<String, dynamic>; // Ambil argumen
        return MaterialPageRoute(
          builder: (_) => DetailRiwayatPage(
            tanggalDiagnosis: args['tanggalDiagnosis'],
            nama: args['nama'],
            statusDiagnosis: args['statusDiagnosis'],
            penyakit: args['penyakit'],
            tanggalPenyakit: args['tanggalPenyakit'],
            langkahPenanganan:
                args['langkahPenanganan'], // Ambil langkah penanganan
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
