class Phone {
  final String number;

  Phone(this.number) {
    if (number.isEmpty) {
      throw ArgumentError('O telefone não pode estar vazio.');
    }
  }

  bool _isValidPassword () {
    final passRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passRegex.hasMatch(number);
  }
}