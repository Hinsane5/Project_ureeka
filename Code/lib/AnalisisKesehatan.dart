import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AnalisisKesehatan extends StatefulWidget {
  const AnalisisKesehatan({super.key});

  @override
  State<AnalisisKesehatan> createState() => _AnalisisKesehatanState();
}

class _AnalisisKesehatanState extends State<AnalisisKesehatan> {
  late final WebViewController _controller;

  final String powerBiUrl =
      'https://app.powerbi.com/view?r=eyJrIjoiYTViNDc1ZTAtNDFjNy00ZjA5LTkwMDQtY2ZlODRlZTlhYmRlIiwidCI6IjM0ODViOTYzLTgyYmEtNGE2Zi04MTBmLWI1Y2MyMjZmZjg5OCIsImMiOjEwfQ%3D%3D';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(powerBiUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: WebViewWidget(controller: _controller),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
