import 'package:flutter/material.dart';

class RekamAktivitas extends StatelessWidget {
  const RekamAktivitas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Rekam Aktivitas",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const SizedBox(height: 32),

            _optionBox(
              context,
              label: "Rekam Tidur",
              image: 'assets/ic_sleep.png',
              backgroundColor: const Color(0xFF00AA41),
              onTap: () {
                Navigator.pushNamed(context, '/rekam_tidur');
              },
            ),

            const SizedBox(height: 32),

            _optionBox(
              context,
              label: "Rekam Olahraga",
              image: "assets/ic_sport.png",
              backgroundColor: const Color(0xFF00709C),
              onTap: () {
                Navigator.pushNamed(context, '/rekam_olahraga');
              },
            ),

            const SizedBox(height: 32),

            _optionBox(
              context,
              label: "Rekam Makan",
              image: "assets/ic_food.png",
              backgroundColor: const Color(0xFF9C0003),
              onTap: () {
                Navigator.pushNamed(context, '/rekam_makan');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionBox(
      BuildContext context, {
        required String label,
        required String image,
        required Color backgroundColor,
        required VoidCallback onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Image.asset(image, width: 100, height: 100),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }
}
