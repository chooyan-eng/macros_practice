import 'package:macros/macros.dart';

macro class RouteMacro implements ClassDeclarationsMacro {
  const RouteMacro();

  @override
  Future<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {

    final widget = clazz.identifier;
    builder.declareInType(DeclarationCode.fromParts([
      '''
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (context) => const ''',
      widget,
      '''(),
    );
  }''',
      ]),
    );
  }
}
