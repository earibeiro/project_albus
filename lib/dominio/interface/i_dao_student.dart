import 'package:albus/dominio/dto/dto_student.dart';

abstract class IDAOStudent {
  Future<DTOStudent> save(DTOStudent dto);
  Future<void> remove(DTOStudent dto); 
}