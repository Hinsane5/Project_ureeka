import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'DetailObat.dart';

class TestCustomVision extends StatefulWidget {
  final String drugName;

  const TestCustomVision({super.key, required this.drugName});

  @override
  State<TestCustomVision> createState() => _TestCustomVisionState();
}

class _TestCustomVisionState extends State<TestCustomVision> {
  File? _image;
  final picker = ImagePicker();
  bool _isSending = false;

  Future<void> _getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _sendImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ambil foto dulu")),
      );
      return;
    }

    setState(() => _isSending = true);

    final bytes = await _image!.readAsBytes();

    final response = await http.post(
      Uri.parse(
        "https://customvisionobat-prediction.cognitiveservices.azure.com/customvision/v3.0/Prediction/59a6025b-a7b2-4623-9a34-c7e0495a8cb6/detect/iterations/Iteration1/image",
      ),
      headers: {
        'Prediction-Key': 'G0SI6VAPdUGe3JfdKFKWTfUOakrsEEd1OCgcpEkn6V1fkqz7qaETJQQJ99BEACqBBLyXJ3w3AAAIACOGo9XD',
        'Content-Type': 'application/octet-stream',
      },
      body: bytes,
    );

    setState(() => _isSending = false);

    if (response.statusCode == 200) {
      print("Sukses: ${response.body}");
      // TODO: Parse response dan pindah ke detail obat.
    } else {
      print("Gagal: ${response.statusCode}");
      print("Error: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal kirim gambar ke server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final drugImage = widget.drugName.toLowerCase() == "panadol"
        ? 'assets/panadol.jpeg'
        : 'assets/bodrex.jpeg';

    return Scaffold(
      appBar: AppBar(title: const Text("Obat")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Text(widget.drugName,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Image.asset(drugImage, height: 120),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _getImageFromCamera,
              child: _image != null
                  ? Image.file(_image!, height: 200)
                  : Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(child: Text("Klik untuk ambil foto")),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSending ? null : _sendImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(16),
              ),
              child: _isSending
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Check Obat"),
            )
          ],
        ),
      ),
    );
  }
}
