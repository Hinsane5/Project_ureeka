import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetTimerObat extends StatefulWidget {
  const SetTimerObat({super.key});

  @override
  State<SetTimerObat> createState() => _AddTimerPageState();
}

class _AddTimerPageState extends State<SetTimerObat> {
  final TextEditingController _namaObatController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _repeatDaily = false;
  bool _playAlarm = true;

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = _selectedTime.format(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 25),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 8),

              // Title
              const Center(
                child: Text(
                  "Atur Waktu Minum Obat",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Nama Obat
              TextField(
                controller: _namaObatController,
                decoration: InputDecoration(
                  hintText: "Tulis nama obat",
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 24),

              // Label Jam
              const Text(
                "Pilih Jam Minum Obat:",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),

              const SizedBox(height: 8),

              // Time Display + Button
              Row(
                children: [
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _selectTime,
                    child: const Text("Pilih Jam"),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Checkbox: Ingatkan harian
              CheckboxListTile(
                value: _repeatDaily,
                onChanged: (val) {
                  setState(() => _repeatDaily = val ?? false);
                },
                title: const Text(
                  "Ingatkan setiap hari",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),

              // Checkbox: Alarm aktif
              CheckboxListTile(
                value: _playAlarm,
                onChanged: (val) {
                  setState(() => _playAlarm = val ?? true);
                },
                title: const Text(
                  "Bunyikan pengingat (alarm)",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),

              const SizedBox(height: 32),

              // Button Simpan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Simpan logika di sini
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Timer disimpan")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Simpan Waktu",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
