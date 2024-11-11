import 'package:flutter/material.dart';
import 'package:albus/routes.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  Widget createButton(BuildContext context, String route, String label) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(label, style: TextStyle(fontSize: 20)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createButton(context, Routes.teacherLogin, 'Eu sou PROFESSOR'),
            SizedBox(height: 20),
            createButton(context, Routes.studentLogin, 'Eu sou ALUNO'),
          ],
        ),
      ),
    );
  }
}