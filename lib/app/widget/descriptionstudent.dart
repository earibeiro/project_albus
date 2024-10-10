import 'package:flutter/material.dart';

class DescriptionStudent extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String cpf;
  final String password;

  DescriptionStudent({
    required this.name,
    required this.email,
    required this.phone,
    required this.cpf,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Aluno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: $name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: $email', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Telefone: $phone', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('CPF: $cpf', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Senha: $password', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}