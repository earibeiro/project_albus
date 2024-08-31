import 'package:albus/dominio/password.dart';
import 'package:flutter_test/flutter_test.dart';

main(){
  group('Entidade Password', () {
    test('Senha válida', () {
      expect(() => Password('Eduardo@12'), returnsNormally);
    });
    test('Senha inválida', () {
      expect(() => Password('eduardo@12'), throwsArgumentError);
    });
  });
}