import 'package:flutter/material.dart';
import 'package:macros_practice/macros/route_macro.dart';

@RouteMacro<int>()
class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
