class Phone {
  final String number;

  Phone(this.number) {
    if (number.isEmpty) {
      throw ArgumentError('O telefone não pode estar vazio.');
    }
    if (!RegExp(r'^\d{10,11}$').hasMatch(number)) {
      throw ArgumentError('O telefone deve conter apenas números e ter 10 ou 11 dígitos.');
    }
  }
}