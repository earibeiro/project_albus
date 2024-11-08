import 'package:albus/dominio/dto/dto_student.dart';
import 'package:flutter/material.dart';


class DescriptionStudent extends StatelessWidget {
  final DTOStudent;

  DescriptionStudent({
    required this.DTOStudent
  });

  @override
  Widget build(BuildContext context) {

    String obscuredPassword = '*' * DTOStudent.password.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Aluno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: $DTOStudent.name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: $DTOStudent.email', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Telefone: $DTOStudent.phone', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('CPF: $DTOStudent.cpf', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Senha: $obscuredPassword', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}