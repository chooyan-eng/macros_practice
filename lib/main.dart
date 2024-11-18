import 'package:flutter/material.dart';
import 'package:macros_practice/macros/value_class_macros.dart';
import 'package:macros_practice/next_page.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MainApp(),
    ),
  );
}

// @ValueClassMacros()
// int age = 0;

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main App'),
      ),
      body: Center(
        child: Text('Value: ${1}'),
        // child: SizedBox(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute<int>(builder: (context) => const NextPage()),
          );
          setState(() {
            _count = result ?? 0;
          });
        },
      ),
    );
  }
}
