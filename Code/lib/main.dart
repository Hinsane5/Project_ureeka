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

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      routes: {
        '/main': (context) => const MainScreen(),
        '/makan_obat': (context) => const MakanObat(),
        '/rekam_aktivitas': (context) => const RekamAktivitas(),
        '/rekam_makan': (context) => const RekamMakan(),
        '/analisis_kesehatan': (context) => const AnalisisKesehatan(),
        '/set_timer_obat': (context) => const SetTimerObat(),
        '/set_timer_aktivitas': (context) => const SetTimerAktivitas(),
        '/lanjut_rekam_makan': (context) => const LanjutRekamMakan(),
      },
    );
  }
}

// Widget to redirect based on login status
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return const MainScreen(); // User is logged in
        } else {
          return const AuthPage(); // Not logged in
        }
      },
    );
  }
}