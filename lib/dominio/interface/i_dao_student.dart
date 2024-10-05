import 'package:albus/dominio/dto/dto_student.dart';

abstract class IDAOStudent {
  Future<DTOStudent> save(DTOStudent dto);
  void remove(DTOStudent dto); 
  Future<DTOStudent> update(DTOStudent dto);
  Future<DTOStudent> read(DTOStudent dto);
  Future<List<DTOStudent>> list();
}