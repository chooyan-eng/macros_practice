import 'dart:async';

import 'package:macros/macros.dart';
import 'package:macros_practice/util/resolve_type.dart';
import 'package:macros_practice/util/strings.dart';

macro class Stateful implements VariableTypesMacro {
  const Stateful();

  @override
  FutureOr<void> buildTypesForVariable(VariableDeclaration variable, TypeBuilder builder) async {
    final inheritedWidgetClassName = '${variable.identifier.name.toPascalCase()}Theme';
    final widgetClassName = '${variable.identifier.name.toPascalCase()}Maintainer';
    final stateClassName = '${widgetClassName}State';
    final statefulWidget = await builder.resolveFrameworkIdentifier('StatefulWidget');
    final state = await builder.resolveFrameworkIdentifier('State');
    final widget = await builder.resolveFrameworkIdentifier('Widget');
    final context = await builder.resolveFrameworkIdentifier('BuildContext');

    builder.declareType(
      widgetClassName,
      DeclarationCode.fromParts([

        'import \'package:flutter/material.dart\';', 
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

    final localVariableName = '_${variable.identifier.name}';
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
        variable.identifier,
        ''';

  void update(String ${variable.identifier.name}) {
    setState(() {
      $localVariableName = ${variable.identifier.name};
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
      ${variable.identifier.name}: $localVariableName,
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
