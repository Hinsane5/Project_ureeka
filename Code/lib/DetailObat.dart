import 'package:flutter/material.dart';

class DetailObat extends StatelessWidget {
  final String namaObat;

  const DetailObat({super.key, required this.namaObat});

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, String>> dataObat = {
      'bodrex': {
        'kandungan': 'Paracetamol dan kafein',
        'fungsi': 'Meringankan sakit kepala, sakit gigi, dan menurunkan demam',
        'gambar': 'assets/bodrex.jpeg',
      },
      'panadol': {
        'kandungan':
        '500 mg Paracetamol, 30 mg Pseudoephedrine HCl, dan 15 mg Dextromethorphan HBr',
        'fungsi':
        'Menurunkan demam serta meredakan nyeri seperti sakit kepala, gigi, atau otot',
        'gambar': 'assets/panadol.jpeg',
      },
      'promag': {
        'kandungan': 'Hydrotalcite 200 mg, Mg(OH)2 150 mg, Simethicone 50 mg',
        'fungsi':
        'Mengurangi gejala kelebihan asam lambung, gastritis, tukak lambung/usus 12 jari',
      },
    };

    final obat = dataObat[namaObat.toLowerCase()];

    return Scaffold(
      appBar: AppBar(
        title: Text(namaObat),
        backgroundColor: const Color(0xFF00AA41),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: obat == null
            ? const Center(
          child: Text(
            "Obat tidak ditemukan",
            style: TextStyle(fontSize: 20),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 250,
                height: 280,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  obat['gambar']!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Kandungan: ${obat['kandungan']}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Fungsi: ${obat['fungsi']}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
