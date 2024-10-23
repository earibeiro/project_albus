class Name {
  String name;

  Name(this.name){
    if(_containsNumbers(name)){
      throw ArgumentError('Nome inválido: não pode conter números!');
    }
  }

  bool _containsNumbers(String str){
    final regex = RegExp(r'[0-9]');
    return regex .hasMatch(str);
  }
}