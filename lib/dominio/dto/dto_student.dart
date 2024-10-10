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

}