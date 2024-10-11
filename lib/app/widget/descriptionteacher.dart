import 'package:flutter/material.dart';

class DescriptionTeacher extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String cpf;
  final String password;

  DescriptionTeacher({
    required this.name,
    required this.email,
    required this.phone,
    required this.cpf,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {

    String obscuredPassword = '*' * password.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Professor'),
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
            Text('Senha: $obscuredPassword', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}