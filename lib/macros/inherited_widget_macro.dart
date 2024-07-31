import 'dart:async';

import 'package:macros/macros.dart';
import 'package:macros_practice/util/resolve_type.dart';

macro class Inherited implements ClassTypesMacro {
  const Inherited();

  @override
  FutureOr<void> buildTypesForClass(
      ClassDeclaration clazz, ClassTypeBuilder builder) async {
    // final baseClassType = clazz.interfaces.first.typeArguments.first;
    final baseClassName = clazz.identifier.name;
    final className = '${baseClassName}Theme';
    final inheritedWidget =
        await builder.resolveFrameworkIdentifier('InheritedWidget');
    final context = await builder.resolveFrameworkIdentifier('BuildContext');

    builder.declareType(
      className,
      DeclarationCode.fromParts([
        '''class $className extends ''',
        inheritedWidget,
        ''' {
  const $className({
    super.key,
    required this.$baseClassName,
    required super.child,
  });

  final ''',
        'String', // TODO(chooyan-eng): how to resolve the type of the variable?
        ''' $baseClassName;
        ''',
      ]),
    );
    builder.declareType(
      '',
      DeclarationCode.fromParts([
        '''
  @override
  bool updateShouldNotify(''',
        inheritedWidget,
        ''' oldWidget) {
    return $baseClassName != (oldWidget as ''',
        className,
        ''').$baseClassName;
  }

  static ''',
        className,
        ' of(',
        context,
        ''' context) {
    return context.dependOnInheritedWidgetOfExactType<''',
        className,
        '''>()!;
  }

  static ''',
        className,
        '? maybeOf(',
        context,
        ''' context) {
    return context.dependOnInheritedWidgetOfExactType<''',
        className,
        '''>();
  }
}
        ''',
      ]),
    );
  }
}
