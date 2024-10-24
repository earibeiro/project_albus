class Phone {
  final String number;

  Phone(this.number) {
    if (number.isEmpty) {
      throw ArgumentError('O telefone não pode estar vazio.');
    }
  }

  bool _isValidPhone () {
    final phoneRegex = RegExp(r'^(\d{2}) \d{5}-\d{4}$');
    return phoneRegex.hasMatch(number);
  }
}