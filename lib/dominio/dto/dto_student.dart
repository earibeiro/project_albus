class DTOStudent {
  late dynamic id;
  late String name;
  late String email;
  late String cpf;
  late String? phone;
  late String password;


  DTOStudent({
    this.id, 
    required this.name, 
    required this.email, 
    required this.cpf, 
    this.phone, 
    required this.password
  });

  factory DTOStudent.fromJson(Map<String, dynamic> json) {
    return DTOStudent(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      cpf: json['cpf'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'cpf': cpf,
      'password': password,
    };
  }
}