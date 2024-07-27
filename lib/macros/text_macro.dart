import 'dart:async';

import 'package:macros/macros.dart';

macro class TextMacro implements VariableTypesMacro {
  const TextMacro();

  @override
  FutureOr<void> buildTypesForVariable(
    VariableDeclaration variable,
    TypeBuilder builder,
  ) async {
    final declarationMacro = await builder.resolveIdentifier(Uri.parse('package:macros_practice/macros/text_macro.dart'), 'TextDeclarationMacro');
    // class name to be generated
    final textClassName = '${variable.identifier.name.toPascalCase()}Text';

    // identifiers
    final statelessWidget = await builder.resolveFrameworkIdentifier('StatelessWidget');

    builder.declareType(
      textClassName,
      DeclarationCode.fromParts([
        '@',
        declarationMacro,
        '''('$textClassName', '${variable.identifier.name}')
        class $textClassName extends ''',
        statelessWidget,
        ''' {
}''',
      ]),
    );
  }
}

macro class TextDeclarationMacro implements ClassDeclarationsMacro {
  const TextDeclarationMacro(this.textClassName, this.variableIdentifier);

  final String textClassName;
  final String variableIdentifier;

  @override
  FutureOr<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    final widget = await builder.resolveFrameworkIdentifier('Widget');
    final context = await builder.resolveFrameworkIdentifier('BuildContext');
    final text = await builder.resolveTextIdentifier('Text');
    final key = await builder.resolveKeyIdentifier('Key');
    builder.declareInType(DeclarationCode.fromParts([


  'const $textClassName({',
        key,
        '''? key}) : super(key: key);
  @override
  ''',
        widget, ' build(', context, ' context) => ', text, '(', variableIdentifier, ');',
    ]));
  }
}
extension on MemberDeclarationBuilder {
  Future<Identifier> resolveTextIdentifier(String name) async {
    return await resolveIdentifier(
      Uri.parse('package:flutter/src/widgets/text.dart'),
      name,
    );
  }

  Future<Identifier> resolveFrameworkIdentifier(String name) async {
    return await resolveIdentifier(
      Uri.parse('package:flutter/src/widgets/framework.dart'),
      name,
    );
  }

  Future<Identifier> resolveKeyIdentifier(String name) async {
    return await resolveIdentifier(
      Uri.parse('package:flutter/src/foundation/key.dart'),
      name,
    );
  }
}

extension on TypeBuilder {
  Future<Identifier> resolveTextIdentifier(String name) async {
    return await resolveIdentifier(
      Uri.parse('package:flutter/src/widgets/text.dart'),
      name,
    );
  }

  Future<Identifier> resolveFrameworkIdentifier(String name) async {
    return await resolveIdentifier(
      Uri.parse('package:flutter/src/widgets/framework.dart'),
      name,
    );
  }
}

extension on String {
  String toPascalCase() {
    final firstLetter = substring(0, 1).toUpperCase();
    return '$firstLetter${substring(1)}';
  }
}