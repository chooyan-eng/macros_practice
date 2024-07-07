@Stateful('BookListPage')
library book_list_page;

import 'package:flutter/material.dart';
import 'package:macros_practice/macros/stateful_widget_macro.dart';

@Stateful('BookListPage')
class BookList {
  BookList({required this.books});

  final List<String> books;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: books.map(_BookTile.new).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            books.add('New Book');
          });
        },
      ),
    );
  }
}

class _BookTile extends StatelessWidget {
  const _BookTile(this.book);

  final String book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(book),
    );
  }
}
