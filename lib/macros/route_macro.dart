import 'package:macros/macros.dart';

macro class RouteMacro implements ClassDeclarationsMacro {
  const RouteMacro();

  @override
  Future<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {

    builder.declareInLibrary(DeclarationCode.fromString(
      "import 'package:flutter/material.dart';",
    ));

    final widget = clazz.identifier;
    final typeArgument = clazz.interfaces.first.typeArguments.first;
    builder.declareInType(DeclarationCode.fromParts([
      '''
static Route<''',
      typeArgument.code,
      '''> route() {
  return MaterialPageRoute<''',
      typeArgument.code,
      '''>(
    builder: (context) => const ''',
      widget,
      '''(),
  );
}
''',
      ]),
    );
  }
}
