import 'package:flutter_test/flutter_test.dart';
import 'package:albus/dominio/phone.dart';

main () {
  group('Entidade Phone', () {
    group('Telefone vazio', () {
      test('Telefone vazio', () {
        expect(() => Phone(''), throwsArgumentError);
      });
    });
  });
}