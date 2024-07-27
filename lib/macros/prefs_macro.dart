import 'dart:async';

import 'package:macros/macros.dart';
import 'package:macros_practice/util/strings.dart';

macro class SharedPreferencesMacro implements ClassDeclarationsMacro {
  const SharedPreferencesMacro();

  @override
  FutureOr<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final className = clazz.identifier.name;
    final fields = await builder.fieldsOf(clazz);

    final sharedPreferences = await builder.resolveIdentifier(Uri.parse('package:shared_preferences/shared_preferences.dart'), 'SharedPreferences');

    builder.declareInType(
      DeclarationCode.fromParts(
        [
          '''
  $className(this.prefs);

  final ''',
  sharedPreferences,
  ''' prefs;
  ''',
        ],
      ),
    );

    final future = await builder.resolveIdentifier(Uri.parse('dart:async'), 'Future');
    final bool = await builder.resolveIdentifier(Uri.parse('dart:core'), 'bool');

    for (final field in fields) {
      final type = field.type;
      final name = field.identifier.name.replaceFirst('_', '').toPascalCase();

      if (name == 'Prefs') {
        continue;
      }

      String typeStr = (type.code.parts[0] as Identifier).name.toPascalCase();

      builder.declareInType(
        DeclarationCode.fromParts(
          [
            '''  ''',
            type.code,
            ''' get$name() {
    return prefs.get$typeStr('$name') ?? ''',
            field.identifier,
            ''';
  }'''
          ],
        ),
        
      );
      
      builder.declareInType(
        DeclarationCode.fromParts(
          [
            '  ',
            future,
            '''<''',
            bool,
            '''> set$name(''',
            type.code,
            ''' value) async {
    return prefs.set$typeStr('$name', value);
  }'''
          ],
        ),
        
      );

    }
  }
}
