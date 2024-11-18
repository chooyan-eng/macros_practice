import 'dart:async';

import 'package:macros/macros.dart';

class ValueClassMacros
    implements VariableTypesMacro, VariableDeclarationsMacro {
  const ValueClassMacros();

  @override
  FutureOr<void> buildTypesForVariable(
    VariableDeclaration variable,
    TypeBuilder builder,
  ) async {
    builder.declareType(
      'AgeValue',
      DeclarationCode.fromParts(
        [
          'class AgeValue {',
          '  int value = 0;',
          '}',
        ],
      ),
    );
  }

  @override
  FutureOr<void> buildDeclarationsForVariable(
    VariableDeclaration variable,
    DeclarationBuilder builder,
  ) {
    builder.declareInLibrary(
      DeclarationCode.fromParts(
        [
          '''
            int value2 = 0;
            int fnc() => 0;
          '''
        ],
      ),
    );
  }
}
