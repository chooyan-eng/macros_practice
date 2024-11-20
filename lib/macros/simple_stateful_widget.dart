import 'dart:async';

import 'package:macros/macros.dart';
import 'package:macros_practice/macros/util/resolve_type.dart';

macro class StatefulMacro implements ClassDeclarationsMacro {
  const StatefulMacro();

  @override
  FutureOr<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final widgetName = clazz.identifier.name;
    final stateName = '${widgetName}State';
    final override = await builder.resolveIdentifier(
      Uri.parse('dart:core'),
      'override',
    );
    final key = await builder.resolveKeyIdentifier('Key');
    final state = await builder.resolveFrameworkIdentifier('State');
    builder.declareInType(
      DeclarationCode.fromParts([
        '''
  const $widgetName({''',
        key,
        '''? key}) : super(key: key);

  @''',
        override,
        '''
  ''',
        state,
        '''<$widgetName> createState() => $stateName();
''',
      ]),
    );
  }
}

macro class StateMacro implements ClassTypesMacro, ClassDeclarationsMacro {
  const StateMacro();

  @override
  FutureOr<void> buildTypesForClass(
    ClassDeclaration clazz,
    ClassTypeBuilder builder,
  ) async {
    final stateClassName = clazz.identifier.name;
    if (!stateClassName.endsWith('State')) {
      builder.report(
        Diagnostic(
          DiagnosticMessage('State class name must end with "State"'),
          Severity.error,
        ),
      );
      return;
    }
    final widgetClassName = stateClassName.replaceFirst('State', '');
    final statefulWidget = await builder.resolveFrameworkIdentifier('StatefulWidget');
    final statefulMacro = await builder.resolveIdentifier(Uri.parse('package:macros_practice/macros/simple_stateful_widget.dart'), 'StatefulMacro');
    builder.declareType(
      widgetClassName,
      DeclarationCode.fromParts(
        [
          '''@''',
          statefulMacro,
          '''()
class $widgetClassName extends ''',
          statefulWidget,
          '{}'
        ],
      ),
    );
  }


  @override
  FutureOr<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final fields = await builder.fieldsOf(clazz);
    final codeParts = fields.map((field) {
      final privateFieldName = field.identifier.name;
      final fieldName = privateFieldName.replaceFirst('_', '');
      final fieldType = field.type;
      return [
        fieldType.code,
        ''' get $fieldName => $privateFieldName;
set $fieldName(''',
        fieldType.code,
        ''' value) {
          setState(() => $privateFieldName = value);
        }
        ''',
      ];
    });
    builder.declareInType(
      DeclarationCode.fromParts(
        codeParts.expand((e) => e).toList(),
      ),
    );
  }
}
