import 'package:flutter_test/flutter_test.dart';
import 'package:albus/dominio/name.dart';

main(){
  group('Entidade nome', () {
    test('Nome válido', () {
      expect(() => Name('Eduardo'), returnsNormally);
    });
    test('Nome inválido', () {
      expect(() => Name('Eduardo1'), throwsArgumentError);
    });
  });
}
