import 'package:flutter/material.dart';

interface class RouteInterface<T> {}

class ArticleListPage extends StatelessWidget implements RouteInterface<int> {
  const ArticleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
