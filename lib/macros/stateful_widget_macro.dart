import 'dart:async';

import 'package:macros/macros.dart';

macro class Stateful implements ClassDeclarationsMacro, LibraryTypesMacro {
  const Stateful(this.statefulWidgetName);

  final String statefulWidgetName;

  @override
  FutureOr<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) {
    
    builder.declareInType(
      DeclarationCode.fromString(
          '  late final void Function(void Function()) setStateFn;'),
    );
    builder.declareInType(
      DeclarationCode.fromString(
        '''
  void setState(void Function() fn) {
    setStateFn(fn);
  }''',
      ),
    );
  }

  @override
  FutureOr<void> buildTypesForLibrary(
      Library library, TypeBuilder builder) async {

    // TODO(chooyan-eng): need to fix an runtime error below
    // 
    // Error: MacroImplementationExceptionImpl: Unable to find
    // top level identifier "BuildContext" in package:flutter/widgets.dart
    final context = await builder.identifierOfFlutter('BuildContext');
    final widget = await builder.identifierOfFlutter('Widget');
    final statefulWidget = await builder.identifierOfFlutter('StatefulWidget');
    final state = await builder.identifierOfFlutter('State');
    final stateName = '_${statefulWidgetName}State';

    // TODO(chooyan-eng): how to detect `List<String> books` part in this method?
    builder.declareType(
      statefulWidgetName,
      DeclarationCode.fromParts([
        '''
class $statefulWidgetName extends ''',
        statefulWidget,
        ''' {
  const $statefulWidgetName({super.key, required this.books});

  final List<String> books;

  @override
  ''',
        state,
        '''<$statefulWidgetName> createState() => $stateName();
}
''',
      ]),
    );

    // TODO(chooyan-eng): how to detect `BookList(books: widget.books)` part
    // in this method?
    builder.declareType(
      stateName,
      DeclarationCode.fromParts(['''
class $stateName extends ''',
      state,
      '''<$statefulWidgetName> {
  @override
  void initState() {
    super.initState();
    bookList = BookList(books: widget.books);
    bookList.setStateFn = setState;
  }

  late final BookList bookList;

  @override
  ''',
      widget,
      ' build(',
      context,
      ''' context) {
    return bookList.build(context);
  }
}
'''
      ]),
    );
  }
}

extension on TypeBuilder {
  Future<Identifier> identifierOfFlutter(String name) async {
    return await resolveIdentifier(
      Uri.parse('package:flutter/widgets.dart'),
      name,
    );
  }
}
