class Email {
  String email;

  Email(this.email) {
    if (email.isEmpty) {
      throw ArgumentError('Email não pode ser vazio!');
    }
    if (!_isValidEmail(email)) {
      throw ArgumentError('Email inválido');
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }
}