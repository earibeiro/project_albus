import 'package:flutter_test/flutter_test.dart';
import 'package:albus/dominio/email.dart';

main() {
  group('Entidade Email', () {
    test('Criação de email', () {
      expect(() => Email('eduardo@dudu.com'), returnsNormally);
    });

    test('Email inválido', () {
      expect(() => Email('eduardo@dudu'), throwsArgumentError);
    });
  });
}