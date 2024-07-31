import 'dart:async';

import 'package:macros/macros.dart';
import 'package:macros_practice/util/resolve_type.dart';

macro class Stateful implements ClassTypesMacro{
  const Stateful();

  @override
  FutureOr<void> buildTypesForClass(ClassDeclaration clazz, ClassTypeBuilder builder) async {
    final inheritedWidgetClassName = '${clazz.identifier.name}Theme';
    final widgetClassName = '${clazz.identifier.name}Maintainer';
    final stateClassName = '${widgetClassName}State';
    final statefulWidget = await builder.resolveFrameworkIdentifier('StatefulWidget');
    final state = await builder.resolveFrameworkIdentifier('State');
    final widget = await builder.resolveFrameworkIdentifier('Widget');
    final context = await builder.resolveFrameworkIdentifier('BuildContext');

    builder.declareType(
      widgetClassName,
      DeclarationCode.fromParts([

        'class $widgetClassName extends ',
        statefulWidget,
        ''' {
  const $widgetClassName({
    super.key,
  });

  static ''',
        stateClassName,
        ' of(',
        context,
        ''' context) {
    return context.findAncestorStateOfType<''',
        stateClassName,
        '''>()!;
  }

  @override
  ''',
        stateClassName,
        ' createState() => ',
        stateClassName,
        '''();
}
'''
      ]),
    );

    final localVariableName = '_${clazz.identifier.name}';
    builder.declareType(
      stateClassName,
      DeclarationCode.fromParts([
        'class $stateClassName extends ',
        state,
        '<',
        widgetClassName,
        '''> {
  ''',
        'String',
        ' $localVariableName = ',
        clazz.identifier,
        ''';

  void update(String ${clazz.identifier.name}) {
    setState(() {
      $localVariableName = ${clazz.identifier.name};
    });
  }

  @override
  ''',
        widget,
        ' build(',
        context,
        ''' context) {
    return ''',
        inheritedWidgetClassName,
        '''(
      ${clazz.identifier.name}: $localVariableName,
      child: const ''',
        inheritedWidgetClassName, 
      '''(),
    );
  }
}''',
      ]),
    );
  }
}
