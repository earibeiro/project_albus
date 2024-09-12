class CPF {
  late List<int> cpfNumbers;

  CPF(String cpf) {
    isEmpty(cpf);
    cpf = cpf.replaceAll(RegExp(r'\D'), '');
    cpfNumbers = cpf.split('').map(int.parse).toList();
    isElevenNumbers();
    isDifferentNumber();
    isCorrectDigit();
  }

  void isEmpty(String cpf) {
    if (cpf.isEmpty) throw Exception('CPF não pode ser vazio!');
  }

  bool isElevenNumbers() {
    if (cpfNumbers.length != 11) throw Exception('CPF deve possuir 11 números!');
    return true;
  }

  bool isDifferentNumber() {
    var different = false;
    for (int i = 0; i < 9; i++) {
      if (cpfNumbers[i] != cpfNumbers[i + 1]) {
        different = true;
        break;
      }
    }
    if (!different) throw Exception('CPF não pode possuir todos os números iguais!');
    return different;
  }

  bool isCorrectDigit() {
    verifyFirstDigit();
    verifySecondDigit();
    return true;
  }

  int calculateDigit(int index) {
    var sum = 0;
    for (var weight = 9; index >= 0; weight--, index--) {
      sum += cpfNumbers[index] * weight;
    }
    var digit = sum % 11;
    if (digit == 10) digit = 0;
    return digit;
  }

  bool verifyFirstDigit() {
    if (calculateDigit(8) != cpfNumbers[9]) throw Exception('O primeiro dígito está incorreto');
    return true;
  }

  bool verifySecondDigit() {
    if (calculateDigit(9) != cpfNumbers[10]) throw Exception('O segundo dígito está incorreto');
    return true;
  }
}