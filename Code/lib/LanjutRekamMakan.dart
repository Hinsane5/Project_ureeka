import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class LanjutRekamMakan extends StatefulWidget {
  const LanjutRekamMakan({super.key});

  @override
  State<LanjutRekamMakan> createState() => _LanjutRekamMakanState();
}

class _LanjutRekamMakanState extends State<LanjutRekamMakan> {
  File? _imageFile;
  String resultText = '';
  final picker = ImagePicker();

  final String apiKey = "3ZBnEWLHj2tVjBDFSGRbhJ66W7RE3GCHqzaLHlNwuPIN63ptlNANJQQJ99BFACqBBLyXJ3w3AAAFACOGW5PU";
  final String endpoint =
      "https://computer-vision-1-makanan.cognitiveservices.azure.com/vision/v3.2/tag";

  Future<void> _getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _sendImageToAzure() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ambil foto dulu")),
      );
      return;
    }

    final bytes = await _imageFile!.readAsBytes();

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Ocp-Apim-Subscription-Key': apiKey,
        'Content-Type': 'application/octet-stream',
      },
      body: bytes,
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List tags = decoded['tags'];

      final Set<String> allowedTags = {
        "pizza", "burger", "french fries", "chicken", "sushi", "noodles", "steak",
        "pasta", "hot dog", "sandwich", "taco", "ramen", "dumpling", "salad",
        "donut", "cake", "ice cream", "rice", "kebab"
      };

      String topTag = '';
      List<String> resultTags = [];

      for (var tag in tags) {
        final name = tag['name'].toString().toLowerCase();
        final confidence = (tag['confidence'] as num) * 100;

        if (allowedTags.contains(name)) {
          resultTags.add("$name (${confidence.toStringAsFixed(0)}%)");
          if (topTag.isEmpty) topTag = name;
        }
      }

      if (resultTags.isNotEmpty) {
        setState(() {
          resultText = "Tags: ${resultTags.join(', ')}";
        });

        final tempDir = await getTemporaryDirectory();
        final savedImage = await _imageFile!.copy('${tempDir.path}/captured.jpg');

        Navigator.pushNamed(
          context,
          '/scan_makanan',
          arguments: {'imagePath': savedImage.path, 'tag': topTag},
        );
      } else {
        setState(() {
          resultText = "Makanan tidak dikenali.";
        });
      }
    } else {
      setState(() {
        resultText = "Gagal koneksi: ${response.statusCode}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/rekam_makan');
                  },
                ),
              ),
              GestureDetector(
                onTap: _getImageFromCamera,
                child: Container(
                  width: double.infinity,
                  height: 450,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _imageFile != null
                      ? Image.file(_imageFile!, fit: BoxFit.cover)
                      : const Center(child: Text("Klik untuk ambil foto")),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                resultText,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _sendImageToAzure,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A9352),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text(
                  "Lanjut Rekam Makanan",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: Colors.white,
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
