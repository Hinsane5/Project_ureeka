import 'package:flutter/material.dart';
import 'package:meditrack/LanjutRekamMakan.dart';
import 'package:meditrack/main_screen.dart';
import 'main_screen.dart';
import 'MakanObat.dart';
import 'RekamAktivitas.dart';
import 'RekamMakan.dart';
import 'AnalisisKesehatan.dart';
import 'SetTimerObat.dart';
import 'SetTimerAktivitas.dart';
import 'Chatbot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/main',
      routes: {
        '/main': (context) => const MainScreen(),
        '/makan_obat': (context) => const MakanObat(),
        '/rekam_aktivitas': (context) => const RekamAktivitas(),
        '/rekam_makan': (context) => const RekamMakan(),
        '/analisis_kesehatan': (context) => const AnalisisKesehatan(),
        '/set_timer_obat': (context) => const SetTimerObat(),
        '/set_timer_aktivitas': (context) => const SetTimerAktivitas(),
        '/lanjut_rekam_makan' : (context) => const LanjutRekamMakan(),
      },
    );
  }
}
