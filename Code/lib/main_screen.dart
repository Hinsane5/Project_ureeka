import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MakanObat.dart';
import 'RekamAktivitas.dart';
import 'AnalisisKesehatan.dart';
import 'SetTimerObat.dart';
import 'SetTimerAktivitas.dart';
import 'Chatbot.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with logout button
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'meditrack',
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF00AA41),
                          fontFamily: 'MainFont',
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.red[600],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.logout, color: Colors.white, size: 18),
                              SizedBox(width: 6),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              _OptionTile(
                color: const Color(0xFF00AA41),
                image: 'assets/ic_medicine.png',
                text: 'Makan Obat',
                imageSize: 72,
                textSize: 32,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const MakanObat()));
                },
              ),

              const SizedBox(height: 24),

              _OptionTile(
                color: const Color(0xFF00709C),
                image: 'assets/ic_task_list.png',
                text: 'Rekam Aktivitas',
                imageSize: 64,
                textSize: 30,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const RekamAktivitas()));
                },
              ),

              const SizedBox(height: 24),

              _OptionTile(
                color: const Color(0xFF9C0003),
                image: 'assets/ic_report.png',
                text: 'Analisis Kesehatan',
                imageSize: 72,
                textSize: 26,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AnalisisKesehatan()));
                },
              ),

              const SizedBox(height: 24),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Set Timer Aktivitas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: _TimerCard(
                        color: const Color(0xFF2A9352),
                        icon: 'assets/ic_timer.png',
                        label: 'Set Timer Obat',
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const SetTimerObat()));
                        },
                      ),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      child: _TimerCard(
                        color: const Color(0xFF089071),
                        icon: 'assets/ic_running_person.png',
                        label: 'Set Timer Aktivitas',
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const SetTimerAktivitas()));
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final Color color;
  final String image;
  final String text;
  final double imageSize;
  final double textSize;
  final VoidCallback onTap;

  const _OptionTile({
    required this.color,
    required this.image,
    required this.text,
    required this.imageSize,
    required this.textSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: Image.asset(
                image,
                width: imageSize,
                height: imageSize,
              ),
            ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: textSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

class _TimerCard extends StatelessWidget {
  final Color color;
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _TimerCard({
    required this.color,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Image.asset(icon, width: 65, height: 65),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
