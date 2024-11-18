import 'package:flutter/material.dart';

interface class RouteInterface<T> {}

class NextPage extends StatelessWidget implements RouteInterface<int> {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pop(context, 42);
      }),
    );
  }
}
