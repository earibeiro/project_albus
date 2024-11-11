import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:flutter/material.dart';

class DescriptionTeacher extends StatelessWidget {
  final DTOTeacher;

  DescriptionTeacher({
    required this.DTOTeacher
  });

  @override
  Widget build(BuildContext context) {

    String obscuredPassword = '*' * DTOTeacher.password.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Professor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: $DTOTeacher.name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: $DTOTeacher.email', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Telefone: $DTOTeacher.phone', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('CPF: $DTOTeacher.cpf', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Senha: $obscuredPassword', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}