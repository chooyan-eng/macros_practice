import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main App'),
      ),
      body: const Center(
        child: Text('Macros Demo'),
      ),
    );
  }
}
