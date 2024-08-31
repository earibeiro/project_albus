class DTOTeacher {
  late dynamic id;
  late String name;
  late String? description;
  late String email;
  late String? phone;
  late String cpf;
  late String? photo;

  DTOTeacher({this.id, required this.name, this.description, required this.email, this.phone, required this.cpf, this.photo});
}