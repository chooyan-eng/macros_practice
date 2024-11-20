import 'dart:async';

import 'package:macros/macros.dart';

macro class HelloWorldMacro implements VariableDeclarationsMacro {
  const HelloWorldMacro();

  @override
  FutureOr<void> buildDeclarationsForVariable(
    VariableDeclaration variable,
    DeclarationBuilder builder,
  ) {
    final varName = variable.identifier.name;

    builder.declareInLibrary(
      DeclarationCode.fromString(
        '// Hello, FlutterKaigi!',
      ),
    );

    builder.declareInLibrary(
      DeclarationCode.fromString(
        '''void sayHello() {
      print($varName);
    }''',
      ),
    );
  }
}
