import 'dart:async';
//
// Don't import this! 
// Unnecessarily importing a big library makes code analysis much slower
// import 'package:flutter/material.dart';

import 'package:macros/macros.dart';

macro class InheritedWidgetMacro implements LibraryDefinitionMacro, LibraryTypesMacro, LibraryDeclarationsMacro, ClassTypesMacro, ClassDeclarationsMacro{
  const InheritedWidgetMacro();

  @override
  FutureOr<void> buildTypesForClass(ClassDeclaration clazz, ClassTypeBuilder builder) async {
    // TODO(chooyan-eng): Can't add super classes with current API.
    // builder.appendSuperClasses([
    //   NamedTypeAnnotationCode(
    //     name: await builder.resolveIdentifier (Uri.parse('package:flutter/widgets.dart'), 'InheritedWidget'),
    //   ),
    // ]);
  }
  
  @override
  FutureOr<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
      // ignore: deprecated_member_use
      builder.declareInType(

      DeclarationCode.fromParts([
        '  const ${clazz.identifier.name}({',
        await builder.resolveIdentifier (Uri.parse('package:flutter/widgets.dart'), 'Key'),
        '? key, required ',
        await builder.resolveIdentifier (Uri.parse('package:flutter/widgets.dart'), 'Widget'),
        ' child}) : super(key: key, child: child);',
      ]),
    );
    builder.declareInType(
      DeclarationCode.fromParts([
        '''
  @override
  bool updateShouldNotify(''',
        await builder.resolveIdentifier (Uri.parse('package:flutter/widgets.dart'), 'InheritedWidget'),
        ''' oldWidget) {
    return true;
  }
        ''',
      ]),
    );

  }
  
  @override
  FutureOr<void> buildDeclarationsForLibrary(Library library, DeclarationBuilder builder) async {    
    // final types = await builder.typesOf(library);
    // final type = types.firstWhere((type) => type.identifier.name == 'ClockThemeMaintainer');
    final state = await builder.resolveIdentifier(Uri.parse('package:flutter/widgets.dart'), 'SizedBox');

    builder.declareInLibrary(
      DeclarationCode.fromParts(['final a = const ', state, '();']),
    );
  }
  
  @override
  FutureOr<void> buildTypesForLibrary(Library library, TypeBuilder builder) async {
    final statefulWidget = await builder.resolveIdentifier(Uri.parse('package:flutter/widgets.dart'), 'StatefulWidget');
    builder.declareType(
      'ClockThemeMaintainer',
      DeclarationCode.fromParts([
        'class ClockThemeMaintainer extends ',
        statefulWidget,
        ''' {
  @override
  ClockThemeMaintainerState createState() => ClockThemeMaintainerState();
}''',
      ]),
    );

    final state = await builder.resolveIdentifier(Uri.parse('package:flutter/widgets.dart'), 'State');
    final widget = await builder.resolveIdentifier(Uri.parse('package:flutter/widgets.dart'), 'Widget');
    final sizedBox = await builder.resolveIdentifier(Uri.parse('package:flutter/widgets.dart'), 'SizedBox');
    final context = await builder.resolveIdentifier(Uri.parse('package:flutter/widgets.dart'), 'BuildContext');
    builder.declareType(
      'ClockThemeMaintainerState',
      DeclarationCode.fromParts([
        'class ClockThemeMaintainerState extends ',
        state,
        '''<ClockThemeMaintainer> {
        ''',
        widget, 
        ''' build(''',
        context,
        ''' context) => ''',
        sizedBox,
        '''();
}
''',
      ]),
    );
  }
  
  @override
  FutureOr<void> buildDefinitionForLibrary(Library library, LibraryDefinitionBuilder builder) {
  }
}