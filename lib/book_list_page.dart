library book_list_page;

import 'package:flutter/material.dart';

class BookListPageState {}

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
