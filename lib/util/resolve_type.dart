import 'package:macros/macros.dart';

extension TypeBuilderExt on TypeBuilder {
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

extension MemberDecralationBuilderExt on MemberDeclarationBuilder {
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
