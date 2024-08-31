class Phone {
  String phone;

  Phone(this.phone) {
    if (phone.isEmpty) {
      throw Exception('Telefone não pode ser vazio!');
    }
    if (!_isValidPhone(phone)) {
      throw Exception('Número de telefone inválido');
    }
  }

  bool _isValidPhone(String phone) {
    // Expressão regular para validar o telefone com DDD
    final phoneRegex = RegExp(r'^\(\d{2}\) \d{4,5}-\d{4}$');
    return phoneRegex.hasMatch(phone);
  }
}