extension StringExt on String {
  String toPascalCase() {
    final firstLetter = substring(0, 1).toUpperCase();
    return '$firstLetter${substring(1)}';
  }
}
