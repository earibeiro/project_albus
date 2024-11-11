class DTOTeacher {
  late dynamic id;
  late String name;
  late String? description;
  late String email;
  late String? phone;
  late String cpf;
  late String password;

  DTOTeacher({
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

  static DTOTeacher fromMap(Map<String, dynamic> map) {
    return DTOTeacher(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      cpf: map['cpf'],
      password: map['password'],
    );
  }
}