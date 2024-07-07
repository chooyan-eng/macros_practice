import 'package:flutter/material.dart';
import 'package:macros_practice/book_list_page.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BookListPage(
      books: [
        'Book1',
        'Book2',
      ],
    );
  }
}
