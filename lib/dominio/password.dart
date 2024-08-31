class Password {
  String password;

  Password(this.password) {
    if(!_isValidPassword(password)) {
      throw ArgumentError('Senha inválida');
    }
  }

  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{10,}$');
    return passwordRegex.hasMatch(password);
  }
}