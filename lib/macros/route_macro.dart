import 'dart:async';

import 'package:macros/macros.dart';

macro class RouteMacro<T> implements ClassDeclarationsMacro {

  const RouteMacro();

  @override
  Future<void> buildDeclarationsForClass(
    ClassDeclaration clazz, 
    MemberDeclarationBuilder builder,
  ) async {
    builder.declareInLibrary(DeclarationCode.fromString(
      "import 'package:flutter/material.dart';",
    ));

    final className = clazz.identifier.name;
    await builder.constructorsOf(clazz);
    builder.declareInType(DeclarationCode.fromParts([
      '  static Route<$T> route() {\n', // TODO(chooyan-eng): can't apply type parameter
      '    return MaterialPageRoute(\n',
      '      builder: (context) => const $className()\n'
      '    );\n',
      '  }',
    ]));
  }
}

