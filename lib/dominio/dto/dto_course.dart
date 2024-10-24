class DTOCourse {
  late dynamic id;
  late String name;
  late int duration; //Não esquecer que a duração ficou em horas!
  late bool isFree;
  late double price;

  DTOCourse({
    this.id,
    required this.name,
    required this.duration,
    required this.isFree,
    required this.price,
  });
}

