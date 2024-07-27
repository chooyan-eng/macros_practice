import 'package:flutter/material.dart';
import 'package:macros_practice/next_page.dart';
import 'package:macros_practice/simple_stateful_widget.dart';
import 'package:macros_practice/title_text.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MainApp(),
    ),
  );
}

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
      body: const Center(
        child: MyWidget(),
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
