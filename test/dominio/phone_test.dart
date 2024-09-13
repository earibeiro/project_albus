import 'package:flutter_test/flutter_test.dart';
import 'package:albus/dominio/phone.dart';

void main() {
  group('Entidade Phone', () {
    group('Telefone vazio', () {
      test('Telefone vazio', () {
        expect(() => Phone(''), throwsArgumentError);
      });
    });

    group('Telefone inválido', () {
      test('Telefone com letras', () {
        expect(() => Phone('123ABC456'), throwsArgumentError);
      });

      test('Telefone com caracteres especiais', () {
        expect(() => Phone('123-456-789'), throwsArgumentError);
      });

      test('Telefone com menos de 10 dígitos', () {
        expect(() => Phone('123456789'), throwsArgumentError);
      });

      test('Telefone com mais de 11 dígitos', () {
        expect(() => Phone('123456789012'), throwsArgumentError);
      });
    });

    group('Telefone válido', () {
      test('Telefone com 10 dígitos', () {
        expect(() => Phone('1234567890'), returnsNormally);
      });

      test('Telefone com 11 dígitos', () {
        expect(() => Phone('12345678901'), returnsNormally);
      });
    });
  });
}