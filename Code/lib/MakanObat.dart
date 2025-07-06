import 'package:flutter/material.dart';
import 'Chatbot.dart';
import 'TestCustomVision.dart';
import 'main_screen.dart';

class MakanObat extends StatelessWidget {
  const MakanObat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MainScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 32),
              width: double.infinity,
              child: const Text(
                "Pilih Cara Lapor Makan Obat",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 24),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TestCustomVision(
                        drugName: 'panadol',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00AA41),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text(
                  "📷 Foto Obat",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Chatbot()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00709C),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text(
                  "🤖 Tanya ke ChatBot",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
