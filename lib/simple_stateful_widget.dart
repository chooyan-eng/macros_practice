import 'package:flutter/material.dart';
import 'package:macros_practice/macros/simple_stateful_widget.dart';

@StateMacro()
class MyWidgetState extends State<MyWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => count++,
      ),
    );
  }
}
