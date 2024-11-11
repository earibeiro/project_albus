class DTOStudent {
  int? id;
  final String name;
  final String email;
  final String phone;
  final String cpf;
  final String password;

  DTOStudent({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.cpf,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'cpf': cpf,
      'password': password,
    };
  }

  static DTOStudent fromMap(Map<String, dynamic> map) {
    return DTOStudent(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      cpf: map['cpf'],
      password: map['password'],
    );
  }
}